use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn minimum_score(n: i32, edges: Vec<Vec<i32>>, scores: Vec<i32>) -> i32 {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in edges.iter() {
            graph.entry(edge[0]).or_insert(vec![]).push(edge[1]);
            graph.entry(edge[1]).or_insert(vec![]).push(edge[0]);
        }

        let mut visited = HashSet::new();
        let mut min_score = std::i32::MAX;

        fn dfs(node: i32, graph: &HashMap<i32, Vec<i32>>, scores: &Vec<i32>, visited: &mut HashSet<i32>, min_score: &mut i32) {
            visited.insert(node);
            *min_score = (*min_score).min(scores[node as usize]);
            for &neighbour in graph.get(&node).unwrap() {
                if !visited.contains(&neighbour) {
                    dfs(neighbour, graph, scores, visited, min_score);
                }
            }
        }

        for i in 0..n {
            if !visited.contains(&(i as i32)) {
                let mut current_min = std::i32::MAX;
                dfs(i, &graph, &scores, &mut visited, &mut current_min);
                min_score = min_score.min(current_min);
            }
        }

        min_score
    }
}