use std::cmp::min;

const INF: i64 = i64::MAX / 2;

impl Solution {
    pub fn minimum_cost(
        source: String,
        target: String,
        original: Vec<char>,
        changed: Vec<char>,
        cost: Vec<i32>,
    ) -> i64 {
        let mut dist: Vec<Vec<i64>> = vec![vec![INF; 26]; 26];

        for i in 0..26 {
            dist[i][i] = 0;
        }

        for i in 0..original.len() {
            let u = (original[i] as u8 - b'a') as usize;
            let v = (changed[i] as u8 - b'a') as usize;
            dist[u][v] = min(dist[u][v], cost[i] as i64);
        }

        for k in 0..26 {
            for i in 0..26 {
                for j in 0..26 {
                    if dist[i][k] != INF && dist[k][j] != INF {
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        let mut total_cost: i64 = 0;
        let source_chars: Vec<char> = source.chars().collect();
        let target_chars: Vec<char> = target.chars().collect();

        for i in 0..source_chars.len() {
            let u = (source_chars[i] as u8 - b'a') as usize;
            let v = (target_chars[i] as u8 - b'a') as usize;

            if u == v {
                continue;
            }

            if dist[u][v] == INF {
                return -1;
            }
            total_cost += dist[u][v];
        }

        total_cost
    }
}