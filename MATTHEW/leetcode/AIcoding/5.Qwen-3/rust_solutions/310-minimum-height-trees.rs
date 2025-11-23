impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn find_min_height_trees(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
        if n == 1 {
            return vec![0];
        }

        let mut adj = HashMap::new();
        for edge in &edges {
            let u = edge[0];
            let v = edge[1];
            adj.entry(u).or_insert(Vec::new()).push(v);
            adj.entry(v).or_insert(Vec::new()).push(u);
        }

        let mut leaves = VecDeque::new();
        for &i in 0..n {
            if adj.get(&i).unwrap().len() == 1 {
                leaves.push_back(i);
            }
        }

        while n > 2 {
            let size = leaves.len();
            for _ in 0..size {
                let leaf = leaves.pop_front().unwrap();
                n -= 1;
                if let Some(neighbors) = adj.get_mut(&leaf) {
                    for &neighbor in neighbors {
                        if let Some(neighbor_neighbors) = adj.get_mut(&neighbor) {
                            neighbor_neighbors.retain(|&x| x != leaf);
                            if neighbor_neighbors.len() == 1 {
                                leaves.push_back(neighbor);
                            }
                        }
                    }
                }
            }
        }

        leaves.into_iter().collect()
    }
}
}