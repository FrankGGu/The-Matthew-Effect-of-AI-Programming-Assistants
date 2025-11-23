use std::collections::{HashMap, HashSet, VecDeque};

pub fn sort_items(n: i32, m: i32, group: Vec<i32>, before_items: Vec<Vec<i32>>) -> Vec<i32> {
    let mut group_map = HashMap::new();
    let mut group_items: Vec<Vec<i32>> = vec![vec![]; m as usize];
    let mut item_graph: Vec<HashSet<i32>> = vec![HashSet::new(); n as usize];
    let mut group_graph: Vec<HashSet<i32>> = vec![HashSet::new(); m as usize];
    let mut item_indegree = vec![0; n as usize];
    let mut group_indegree = vec![0; m as usize];

    for (i, &g) in group.iter().enumerate() {
        if g == -1 {
            group_map.insert(i as i32, group_map.len() as i32);
            group_items.push(vec![i as i32]);
        } else {
            group_items[g as usize].push(i as i32);
        }
    }

    for (i, items) in before_items.iter().enumerate() {
        for &pre in items {
            item_graph[pre as usize].insert(i);
            item_indegree[i as usize] += 1;
            if group[pre as usize] != group[i as usize] {
                group_graph[group[pre as usize] as usize].insert(group[i as usize]);
                group_indegree[group[i as usize] as usize] += 1;
            }
        }
    }

    fn topological_sort(graph: &Vec<HashSet<i32>>, indegree: &mut Vec<i32>) -> Vec<i32> {
        let mut result = vec![];
        let mut queue = VecDeque::new();
        for i in 0..indegree.len() {
            if indegree[i] == 0 {
                queue.push_back(i as i32);
            }
        }
        while let Some(node) = queue.pop_front() {
            result.push(node);
            for &next in &graph[node as usize] {
                indegree[next as usize] -= 1;
                if indegree[next as usize] == 0 {
                    queue.push_back(next);
                }
            }
        }
        if result.len() == graph.len() {
            result
        } else {
            vec![]
        }
    }

    let sorted_groups = topological_sort(&group_graph, &mut group_indegree.clone());
    if sorted_groups.is_empty() {
        return vec![];
    }

    let mut sorted_items = vec![];
    for group_id in sorted_groups {
        let items = &group_items[group_id as usize];
        let mut group_item_graph = vec![HashSet::new(); items.len()];
        let mut item_indegree = vec![0; items.len()];

        for &item in items {
            for &next in &item_graph[item as usize] {
                if group[next as usize] == group_id {
                    group_item_graph[item as usize].insert(next);
                    item_indegree[next as usize] += 1;
                }
            }
        }

        let sorted_items_in_group = topological_sort(&group_item_graph, &mut item_indegree);
        if sorted_items_in_group.is_empty() {
            return vec![];
        }
        sorted_items.extend(sorted_items_in_group.iter().map(|&item| item));
    }

    sorted_items
}