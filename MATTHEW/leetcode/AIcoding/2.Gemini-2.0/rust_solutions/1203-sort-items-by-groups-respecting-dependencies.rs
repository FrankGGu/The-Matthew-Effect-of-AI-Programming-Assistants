use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn sort_items(n: i32, m: i32, group: Vec<i32>, before_items: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let m = m as usize;

        let mut group_id = group;
        for i in 0..n {
            if group_id[i] == -1 {
                group_id[i] = m as i32 + i as i32;
            }
        }

        let num_groups = (m as i32 + n as i32) as usize;

        let mut item_graph: Vec<Vec<usize>> = vec![vec![]; n];
        let mut item_indegree: Vec<i32> = vec![0; n];
        let mut group_graph: Vec<Vec<usize>> = vec![vec![]; num_groups];
        let mut group_indegree: Vec<i32> = vec![0; num_groups];

        for i in 0..n {
            for &prev in &before_items[i] {
                let prev = prev as usize;
                if group_id[i] == group_id[prev] {
                    item_graph[prev].push(i);
                    item_indegree[i] += 1;
                } else {
                    let group_i = group_id[i] as usize;
                    let group_prev = group_id[prev] as usize;
                    group_graph[group_prev].push(group_i);
                    group_indegree[group_i] += 1;
                }
            }
        }

        fn topological_sort(graph: &Vec<Vec<usize>>, indegree: &Vec<i32>) -> Option<Vec<usize>> {
            let n = graph.len();
            let mut indegree = indegree.clone();
            let mut queue: VecDeque<usize> = VecDeque::new();
            for i in 0..n {
                if indegree[i] == 0 {
                    queue.push_back(i);
                }
            }

            let mut result: Vec<usize> = Vec::new();
            while let Some(node) = queue.pop_front() {
                result.push(node);
                for &neighbor in &graph[node] {
                    indegree[neighbor] -= 1;
                    if indegree[neighbor] == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }

            if result.len() == n {
                Some(result)
            } else {
                None
            }
        }

        let item_order = topological_sort(&item_graph, &item_indegree)?;
        let group_order = topological_sort(&group_graph, &group_indegree)?;

        let mut group_to_items: HashMap<usize, Vec<usize>> = HashMap::new();
        for &item in &item_order {
            let group = group_id[item] as usize;
            group_to_items.entry(group).or_insert(Vec::new()).push(item);
        }

        let mut result: Vec<i32> = Vec::new();
        for &group in &group_order {
            if let Some(items) = group_to_items.get(&group) {
                for &item in items {
                    result.push(item as i32);
                }
            }
        }

        Some(result)
    }
}