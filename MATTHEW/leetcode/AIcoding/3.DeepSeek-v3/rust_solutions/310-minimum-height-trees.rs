use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn find_min_height_trees(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        if n == 1 {
            return vec![0];
        }

        let n = n as usize;
        let mut adj = vec![HashSet::new(); n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].insert(v);
            adj[v].insert(u);
        }

        let mut leaves = VecDeque::new();
        for i in 0..n {
            if adj[i].len() == 1 {
                leaves.push_back(i);
            }
        }

        let mut remaining_nodes = n;
        while remaining_nodes > 2 {
            let num_leaves = leaves.len();
            remaining_nodes -= num_leaves;
            for _ in 0..num_leaves {
                let leaf = leaves.pop_front().unwrap();
                let neighbor = *adj[leaf].iter().next().unwrap();
                adj[neighbor].remove(&leaf);
                if adj[neighbor].len() == 1 {
                    leaves.push_back(neighbor);
                }
            }
        }

        leaves.into_iter().map(|x| x as i32).collect()
    }
}