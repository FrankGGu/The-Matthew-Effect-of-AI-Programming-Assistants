use std::collections::HashMap;

impl Solution {
    pub fn maximum_importance(n: i32, roads: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let mut degree = vec![0; n];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            degree[u] += 1;
            degree[v] += 1;
        }
        degree.sort_unstable();
        let mut total = 0;
        for (i, &d) in degree.iter().enumerate() {
            total += d as i64 * (i + 1) as i64;
        }
        total
    }
}