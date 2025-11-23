impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn min_operations(target: String, original: String, changed: String, cost: Vec<i32>) -> i32 {
        let mut graph = HashMap::new();
        for i in 0..original.len() {
            let o = original.as_bytes()[i] as u8;
            let c = changed.as_bytes()[i] as u8;
            let w = cost[i];
            graph.entry(o).or_insert_with(HashMap::new).insert(c, w);
        }

        let mut dist = vec![vec![i32::MAX; 256]; 256];
        for i in 0..256 {
            dist[i][i] = 0;
        }

        for (u, edges) in &graph {
            for (&v, &w) in edges {
                dist[*u as usize][v as usize] = w;
            }
        }

        for k in 0..256 {
            for i in 0..256 {
                for j in 0..256 {
                    if dist[i][k] != i32::MAX && dist[k][j] != i32::MAX {
                        dist[i][j] = std::cmp::min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        let target_bytes = target.as_bytes();
        let mut res = 0;
        let mut i = 0;
        while i < target_bytes.len() {
            let t = target_bytes[i] as u8;
            let mut found = false;
            for j in 0..original.len() {
                let o = original.as_bytes()[j] as u8;
                if o == t {
                    let c = changed.as_bytes()[j] as u8;
                    if dist[o as usize][c as usize] != i32::MAX {
                        res += dist[o as usize][c as usize];
                        i += 1;
                        found = true;
                        break;
                    }
                }
            }
            if !found {
                return -1;
            }
        }

        res
    }
}
}