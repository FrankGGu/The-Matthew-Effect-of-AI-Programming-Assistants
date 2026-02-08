use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn get_ancestors(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n_usize = n as usize;

        let mut rev_adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize; // from
            let v = edge[1] as usize; // to
            // In the original graph, u -> v means u is an ancestor of v.
            // In the reversed graph, this means there's an edge v -> u.
            // So, to find ancestors of v, we traverse from v in the reversed graph.
            rev_adj[v].push(u);
        }

        let mut ancestors: Vec<Vec<i32>> = vec![vec![]; n_usize];

        for i in 0..n_usize {
            let mut visited: Vec<bool> = vec![false; n_usize];
            let mut queue: VecDeque<usize> = VecDeque::new();

            queue.push_back(i);
            visited[i] = true;

            let mut current_ancestors_set: HashSet<i32> = HashSet::new();

            while let Some(u) = queue.pop_front() {
                // All nodes 'u' reachable from 'i' in the reversed graph (excluding 'i' itself)
                // are ancestors of 'i' in the original graph.
                if u != i {
                    current_ancestors_set.insert(u as i32);
                }

                for &v in &rev_adj[u] {
                    if !visited[v] {
                        visited[v] = true;
                        queue.push_back(v);
                    }
                }
            }

            let mut current_ancestors_vec: Vec<i32> = current_ancestors_set.into_iter().collect();
            current_ancestors_vec.sort_unstable();
            ancestors[i] = current_ancestors_vec;
        }

        ancestors
    }
}