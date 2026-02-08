use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn sort_items(n: i32, m: i32, group: Vec<i32>, before_items: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let m = m as usize;

        let mut group_map = group;
        let mut next_group_id = m;
        for i in 0..n {
            if group_map[i] == -1 {
                group_map[i] = next_group_id as i32;
                next_group_id += 1;
            }
        }
        let total_groups = next_group_id;

        let mut item_adj: Vec<Vec<i32>> = vec![vec![]; n];
        let mut item_indegree: Vec<i32> = vec![0; n];

        let mut group_adj_set: Vec<HashSet<i32>> = vec![HashSet::new(); total_groups];
        let mut group_indegree: Vec<i32> = vec![0; total_groups];

        let mut items_in_each_group: Vec<Vec<i32>> = vec![vec![]; total_groups];
        for i in 0..n {
            items_in_each_group[group_map[i] as usize].push(i as i32);
        }

        for i in 0..n {
            for &j in before_items[i].iter() {
                item_adj[j as usize].push(i as i32);
                item_indegree[i] += 1;

                if group_map[j as usize] != group_map[i] {
                    let g_j = group_map[j as usize] as usize;
                    let g_i = group_map[i] as usize;
                    if group_adj_set[g_j].insert(g_i as i32) {
                        group_indegree[g_i] += 1;
                    }
                }
            }
        }

        let mut group_adj: Vec<Vec<i32>> = vec![vec![]; total_groups];
        for i in 0..total_groups {
            for &g_neighbor in group_adj_set[i].iter() {
                group_adj[i].push(g_neighbor);
            }
        }

        let topological_sort = |n_nodes: usize, adj: &Vec<Vec<i32>>, mut indegree: Vec<i32>, nodes_to_consider: Option<&HashSet<i32>>| -> Vec<i32> {
            let mut q: VecDeque<i32> = VecDeque::new();
            let mut res: Vec<i32> = Vec::new();
            let expected_nodes_count;

            if let Some(nodes_set) = nodes_to_consider {
                for &node_id in nodes_set.iter() {
                    if indegree[node_id as usize] == 0 {
                        q.push_back(node_id);
                    }
                }
                expected_nodes_count = nodes_set.len();
            } else {
                for i in 0..n_nodes {
                    if indegree[i] == 0 {
                        q.push_back(i as i32);
                    }
                }
                expected_nodes_count = n_nodes;
            }

            let mut processed_nodes_count = 0;

            while let Some(u) = q.pop_front() {
                res.push(u);
                processed_nodes_count += 1;

                for &v in adj[u as usize].iter() {
                    let v_in_consideration = if let Some(nodes_set) = nodes_to_consider {
                        nodes_set.contains(&v)
                    } else {
                        true
                    };

                    if v_in_consideration {
                        indegree[v as usize] -= 1;
                        if indegree[v as usize] == 0 {
                            q.push_back(v);
                        }
                    }
                }
            }

            if processed_nodes_count != expected_nodes_count {
                vec![]
            } else {
                res
            }
        };

        let group_order = topological_sort(total_groups, &group_adj, group_indegree, None);
        if group_order.is_empty() {
            return vec![];
        }

        let mut sorted_items_in_each_group: Vec<Vec<i32>> = vec![vec![]; total_groups];
        for g_id in 0..total_groups {
            let current_group_items_vec = &items_in_each_group[g_id];
            let num_items_in_group = current_group_items_vec.len();

            if num_items_in_group == 0 {
                continue;
            }

            let current_group_items_set: HashSet<i32> = current_group_items_vec.iter().cloned().collect();

            let mut local_item_indegree = vec![0; n];
            for &item_u in current_group_items_vec.iter() {
                for &item_v in item_adj[item_u as usize].iter() {
                    if current_group_items_set.contains(&item_v) {
                        local_item_indegree[item_v as usize] += 1;
                    }
                }
            }

            let sorted_items = topological_sort(n, &item_adj, local_item_indegree, Some(&current_group_items_set));

            if sorted_items.len() != num_items_in_group {
                return vec![];
            }
            sorted_items_in_each_group[g_id] = sorted_items;
        }

        let mut final_result: Vec<i32> = Vec::new();
        for &g_id in group_order.iter() {
            final_result.extend_from_slice(&sorted_items_in_each_group[g_id as usize]);
        }

        final_result
    }
}