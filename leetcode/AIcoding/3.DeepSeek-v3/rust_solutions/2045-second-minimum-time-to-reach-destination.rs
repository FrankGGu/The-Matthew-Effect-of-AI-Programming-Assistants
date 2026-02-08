use std::collections::{BinaryHeap, VecDeque};
use std::cmp::Reverse;

impl Solution {
    pub fn second_minimum(n: i32, edges: Vec<Vec<i32>>, time: i32, change: i32) -> i32 {
        let n = n as usize;
        let mut adj = vec![vec![]; n + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dist = vec![vec![]; n + 1];
        dist[1].push(0);
        let mut queue = VecDeque::new();
        queue.push_back((1, 0));

        while let Some((u, t)) = queue.pop_front() {
            for &v in &adj[u] {
                let mut new_t = t + time;
                let cycles = new_t / change;
                if cycles % 2 == 1 {
                    new_t = (cycles + 1) * change;
                }
                if dist[v].len() == 0 {
                    dist[v].push(new_t);
                    queue.push_back((v, new_t));
                } else if dist[v].len() == 1 && dist[v][0] < new_t {
                    dist[v].push(new_t);
                    queue.push_back((v, new_t));
                } else if dist[v].len() == 2 && new_t > dist[v][0] && new_t < dist[v][1] {
                    dist[v][1] = new_t;
                    queue.push_back((v, new_t));
                }
            }
        }

        dist[n][1]
    }
}