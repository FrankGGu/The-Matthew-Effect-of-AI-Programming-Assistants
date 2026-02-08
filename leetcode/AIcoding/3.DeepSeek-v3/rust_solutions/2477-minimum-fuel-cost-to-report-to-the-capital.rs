use std::collections::VecDeque;

impl Solution {
    pub fn minimum_fuel_cost(roads: Vec<Vec<i32>>, seats: i32) -> i64 {
        let n = roads.len() + 1;
        let mut adj = vec![vec![]; n];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut degree = vec![0; n];
        let mut q = VecDeque::new();
        for i in 1..n {
            degree[i] = adj[i].len();
            if degree[i] == 1 {
                q.push_back(i);
            }
        }

        let mut res = 0;
        let mut count = vec![1; n];
        while let Some(u) = q.pop_front() {
            for &v in &adj[u] {
                if degree[v] == 0 {
                    continue;
                }
                let cars = (count[u] as f64 / seats as f64).ceil() as i64;
                res += cars;
                count[v] += count[u];
                degree[v] -= 1;
                if degree[v] == 1 && v != 0 {
                    q.push_back(v);
                }
            }
            degree[u] = 0;
        }
        res
    }
}