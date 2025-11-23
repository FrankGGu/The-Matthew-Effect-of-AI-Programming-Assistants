impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_network_rank(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut degree = vec![0; n];
        let mut connected = HashMap::new();

        for road in &roads {
            let (u, v) = (road[0] as usize, road[1] as usize);
            degree[u] += 1;
            degree[v] += 1;
            connected.insert((u, v), true);
            connected.insert((v, u), true);
        }

        let mut max_rank = 0;

        for i in 0..n {
            for j in i+1..n {
                if connected.get(&(i, j)).is_some() {
                    max_rank = max_rank.max(degree[i] + degree[j]);
                }
            }
        }

        max_rank
    }
}
}