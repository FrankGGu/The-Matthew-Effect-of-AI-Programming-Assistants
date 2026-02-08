use std::collections::HashMap;

impl Solution {
    pub fn minimum_cost(source: String, target: String, original: Vec<String>, changed: Vec<String>, cost: Vec<i32>) -> i64 {
        let n = source.len();
        let m = original.len();
        let mut adj = vec![vec![i32::MAX; 26]; 26];

        for i in 0..26 {
            adj[i][i] = 0;
        }

        for i in 0..m {
            let u = original[i].chars().next().unwrap() as usize - 'a' as usize;
            let v = changed[i].chars().next().unwrap() as usize - 'a' as usize;
            adj[u][v] = adj[u][v].min(cost[i]);
        }

        for k in 0..26 {
            for i in 0..26 {
                for j in 0..26 {
                    if adj[i][k] != i32::MAX && adj[k][j] != i32::MAX {
                        adj[i][j] = adj[i][j].min(adj[i][k].saturating_add(adj[k][j]));
                    }
                }
            }
        }

        let mut ans: i64 = 0;
        for i in 0..n {
            let u = source.chars().nth(i).unwrap() as usize - 'a' as usize;
            let v = target.chars().nth(i).unwrap() as usize - 'a' as usize;

            if u == v {
                continue;
            }

            if adj[u][v] == i32::MAX {
                return -1;
            }

            ans += adj[u][v] as i64;
        }

        ans
    }
}