use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn most_profitable_path(edges: Vec<Vec<i32>>, bob: Vec<i32>, amount: Vec<i32>, start: i32) -> Vec<i32> {
        let n = amount.len();
        let mut graph = vec![Vec::new(); n];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1]);
            graph[edge[1] as usize].push(edge[0]);
        }

        let mut bob_path = vec![0; n];
        let mut visited = HashSet::new();
        let mut queue = vec![(bob[0], 0)];
        while let Some((node, idx)) = queue.pop() {
            if visited.insert(node) {
                bob_path[node as usize] = idx;
                for &neighbor in &graph[node as usize] {
                    queue.push((neighbor, idx + 1));
                }
            }
        }

        let mut best_profit = i32::MIN;
        let mut best_path = vec![];
        let mut current_profit = 0;

        fn dfs(node: i32, parent: i32, current_profit: &mut i32, path: &mut Vec<i32>, best_profit: &mut i32, best_path: &mut Vec<i32>, graph: &Vec<Vec<i32>>, bob_path: &Vec<i32>, amount: &Vec<i32>, start: i32) {
            path.push(node);
            let idx = bob_path[node as usize];
            if idx == 0 && parent == -1 {
                *current_profit += amount[node as usize];
            } else if idx > 0 {
                if idx < path.len() {
                    *current_profit += amount[node as usize] / 2;
                } else {
                    *current_profit += amount[node as usize];
                }
            }
            if node == start {
                if *current_profit > *best_profit {
                    *best_profit = *current_profit;
                    *best_path = path.clone();
                }
            }
            for &neighbor in &graph[node as usize] {
                if neighbor != parent {
                    dfs(neighbor, node, current_profit, path, best_profit, best_path, graph, bob_path, amount, start);
                }
            }
            if idx == 0 && parent == -1 {
                *current_profit -= amount[node as usize];
            } else if idx > 0 {
                if idx < path.len() {
                    *current_profit -= amount[node as usize] / 2;
                } else {
                    *current_profit -= amount[node as usize];
                }
            }
            path.pop();
        }

        let mut path = vec![];
        dfs(start, -1, &mut current_profit, &mut path, &mut best_profit, &mut best_path, &graph, &bob_path, &amount, start);
        best_path
    }
}