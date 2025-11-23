use std::collections::VecDeque;

impl Solution {
    pub fn min_reorder(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, bool)>> = vec![vec![]; n];

        for connection in connections {
            let u = connection[0] as usize;
            let v = connection[1] as usize;
            adj[u].push((v, true));
            adj[v].push((u, false));
        }

        let mut reversals = 0;
        let mut visited: Vec<bool> = vec![false; n];
        let mut q: VecDeque<usize> = VecDeque::new();

        q.push_back(0);
        visited[0] = true;

        while let Some(u) = q.pop_front() {
            for &(v, is_outgoing) in &adj[u] {
                if !visited[v] {
                    visited[v] = true;
                    if is_outgoing {
                        reversals += 1;
                    }
                    q.push_back(v);
                }
            }
        }

        reversals
    }
}