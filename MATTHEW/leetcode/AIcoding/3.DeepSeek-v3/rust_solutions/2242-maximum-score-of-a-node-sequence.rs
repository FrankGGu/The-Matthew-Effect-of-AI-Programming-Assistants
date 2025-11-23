use std::collections::HashSet;

impl Solution {
    pub fn maximum_score(scores: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = scores.len();
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph[u].push((scores[v], v));
            graph[v].push((scores[u], u));
        }

        for neighbors in graph.iter_mut() {
            neighbors.sort_unstable_by(|a, b| b.0.cmp(&a.0));
            if neighbors.len() > 3 {
                neighbors.truncate(3);
            }
        }

        let mut max_score = -1;
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let base = scores[u] + scores[v];

            for &(score_a, a) in &graph[u] {
                if a == v {
                    continue;
                }
                for &(score_b, b) in &graph[v] {
                    if b == u || b == a {
                        continue;
                    }
                    let total = base + score_a + score_b;
                    if total > max_score {
                        max_score = total;
                    }
                }
            }
        }

        max_score
    }
}