use std::cmp::max;

impl Solution {
    pub fn maximum_score(scores: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = scores.len();
        let mut adj: Vec<Vec<(i32, i32)>> = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push((scores[v], v as i32));
            adj[v].push((scores[u], u as i32));
        }

        for i in 0..n {
            adj[i].sort_by(|a, b| b.0.cmp(&a.0));
            if adj[i].len() > 3 {
                adj[i].truncate(3);
            }
        }

        let mut max_score = -1;

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;

            for &(score_a, a) in &adj[u] {
                let a = a as usize;
                if a == v {
                    continue;
                }

                for &(score_b, b) in &adj[v] {
                    let b = b as usize;
                    if b == u || b == a {
                        continue;
                    }

                    max_score = max(max_score, scores[u] + scores[v] + score_a + score_b);
                }
            }
        }

        max_score
    }
}