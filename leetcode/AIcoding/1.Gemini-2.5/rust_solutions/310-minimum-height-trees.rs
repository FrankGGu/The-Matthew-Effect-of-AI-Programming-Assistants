use std::collections::VecDeque;

impl Solution {
    pub fn find_min_height_trees(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        if n == 1 {
            return vec![0];
        }

        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        let mut degree: Vec<i32> = vec![0; n_usize];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut q: VecDeque<usize> = VecDeque::new();
        for i in 0..n_usize {
            if degree[i] == 1 { // Initialize queue with all leaf nodes
                q.push_back(i);
            }
        }

        let mut remaining_nodes = n_usize;

        // Keep removing leaves layer by layer until 1 or 2 nodes remain
        while remaining_nodes > 2 {
            let num_leaves_in_current_layer = q.len();
            remaining_nodes -= num_leaves_in_current_layer;

            for _ in 0..num_leaves_in_current_layer {
                let u = q.pop_front().unwrap();

                for &v in &adj[u] {
                    degree[v] -= 1;
                    if degree[v] == 1 { // If neighbor becomes a new leaf, add to queue
                        q.push_back(v);
                    }
                }
            }
        }

        // The remaining nodes in the queue are the roots of MHTs
        q.iter().map(|&node| node as i32).collect()
    }
}