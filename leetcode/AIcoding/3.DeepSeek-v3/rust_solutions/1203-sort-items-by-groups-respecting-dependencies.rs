use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn sort_items(n: i32, m: i32, group: Vec<i32>, before_items: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let m = m as usize;
        let mut group = group;
        let mut group_id = m;
        for g in &mut group {
            if *g == -1 {
                *g = group_id as i32;
                group_id += 1;
            }
        }

        let mut item_graph = vec![vec![]; n];
        let mut item_indegree = vec![0; n];

        let mut group_graph = vec![vec![]; group_id];
        let mut group_indegree = vec![0; group_id];

        for curr in 0..n {
            for &prev in &before_items[curr] {
                let prev = prev as usize;
                item_graph[prev].push(curr);
                item_indegree[curr] += 1;

                let curr_group = group[curr] as usize;
                let prev_group = group[prev] as usize;
                if curr_group != prev_group {
                    group_graph[prev_group].push(curr_group);
                    group_indegree[curr_group] += 1;
                }
            }
        }

        fn topological_sort(graph: &Vec<Vec<usize>>, indegree: &Vec<i32>) -> Vec<usize> {
            let mut queue = VecDeque::new();
            let mut result = Vec::new();
            for (node, &degree) in indegree.iter().enumerate() {
                if degree == 0 {
                    queue.push_back(node);
                }
            }

            while let Some(node) = queue.pop_front() {
                result.push(node);
                for &neighbor in &graph[node] {
                    indegree[neighbor] -= 1;
                    if indegree[neighbor] == 0 {
                        queue.push_back(neighbor);
                    }
                }
            }

            if result.len() == graph.len() {
                result
            } else {
                vec![]
            }
        }

        let group_order = topological_sort(&group_graph, &group_indegree);
        if group_order.is_empty() {
            return vec![];
        }

        let mut item_order = topological_sort(&item_graph, &item_indegree);
        if item_order.is_empty() {
            return vec![];
        }

        let mut group_to_items = HashMap::new();
        for &item in &item_order {
            group_to_items.entry(group[item] as usize).or_insert(vec![]).push(item as i32);
        }

        let mut result = Vec::new();
        for &group_id in &group_order {
            if let Some(items) = group_to_items.get(&group_id) {
                result.extend(items);
            }
        }

        result
    }
}