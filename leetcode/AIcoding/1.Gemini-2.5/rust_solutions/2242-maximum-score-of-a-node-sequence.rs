use std::cmp::max;

impl Solution {
    pub fn maximum_score(scores: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = scores.len();

        // Adjacency list to store neighbors and their scores.
        // For each node u, we store a list of (score_v, v) for its neighbors v.
        // We will later sort these and keep only the top 3 by score.
        let mut adj: Vec<Vec<(i32, usize)>> = vec![vec![]; n];

        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push((scores[v], v));
            adj[v].push((scores[u], u));
        }

        // For each node, sort its neighbors by their scores in descending order
        // and keep only the top 3. This optimization is crucial for performance.
        for i in 0..n {
            adj[i].sort_unstable_by(|a, b| b.0.cmp(&a.0)); // Sort by score descending
            adj[i].truncate(3); // Keep only the top 3 neighbors
        }

        let mut max_total_score = -1;

        // Iterate through each edge (b, c) in the graph.
        // This edge forms the middle segment of our 4-node sequence (a, b, c, d).
        for edge in &edges {
            let b = edge[0] as usize;
            let c = edge[1] as usize;

            // Iterate through potential 'a' nodes connected to 'b'.
            // These are the top-scoring neighbors of 'b'.
            for &(score_a, a) in &adj[b] {
                // 'a' must be distinct from 'c'.
                if a == c {
                    continue;
                }

                // Iterate through potential 'd' nodes connected to 'c'.
                // These are the top-scoring neighbors of 'c'.
                for &(score_d, d) in &adj[c] {
                    // 'd' must be distinct from 'b'.
                    if d == b {
                        continue;
                    }
                    // 'a' and 'd' must also be distinct from each other.
                    if a == d {
                        continue;
                    }

                    // If all conditions are met, we have a valid sequence (a, b, c, d).
                    // Calculate its total score.
                    let current_score = scores[a] + scores[b] + scores[c] + scores[d];
                    // Update the maximum total score found so far.
                    max_total_score = max(max_total_score, current_score);
                }
            }
        }

        max_total_score
    }
}