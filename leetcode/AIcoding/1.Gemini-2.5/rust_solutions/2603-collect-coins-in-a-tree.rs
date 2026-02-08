use std::collections::VecDeque;

impl Solution {
    pub fn collect_coins(coins: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = coins.len();
        if n <= 1 {
            return 0;
        }

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        let mut degree: Vec<i32> = vec![0; n]; // Current degree in the active subgraph

        for edge in edges.iter() {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut removed: Vec<bool> = vec![false; n];
        let mut q: VecDeque<usize> = VecDeque::new();

        // Pass 1: Iteratively remove nodes that are leaves (degree 1) or isolated (degree 0)
        // and do not have coins.
        for i in 0..n {
            if degree[i] <= 1 && coins[i] == 0 {
                q.push_back(i);
                removed[i] = true; 
            }
        }

        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                if !removed[v] {
                    degree[v] -= 1;
                    // If v becomes a leaf (degree 1) or isolated (degree 0) and has no coin,
                    // it's also a candidate for removal.
                    if degree[v] <= 1 && coins[v] == 0 {
                        q.push_back(v);
                        removed[v] = true;
                    }
                }
            }
        }

        // Pass 2: Remove all current leaves (one layer), regardless of coins.
        // These are nodes that are 1 step away from the leaves of the tree after Pass 1.
        q.clear();
        for i in 0..n {
            if !removed[i] && degree[i] == 1 { // These are the new leaves after Pass 1
                q.push_back(i);
                removed[i] = true; 
            }
        }

        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                if !removed[v] {
                    degree[v] -= 1;
                }
            }
        }

        // Pass 3: Remove all current leaves (another layer), regardless of coins.
        // These are nodes that are 2 steps away from the leaves of the tree after Pass 1.
        q.clear();
        for i in 0..n {
            if !removed[i] && degree[i] == 1 { // These are the new leaves after Pass 2
                q.push_back(i);
                removed[i] = true;
            }
        }

        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                if !removed[v] {
                    degree[v] -= 1;
                }
            }
        }

        // Count edges in the remaining "effective" tree
        let mut num_edges = 0;
        for u in 0..n {
            if !removed[u] {
                for &v in &adj[u] {
                    if !removed[v] && u < v { // Count each edge once
                        num_edges += 1;
                    }
                }
            }
        }

        num_edges * 2
    }
}