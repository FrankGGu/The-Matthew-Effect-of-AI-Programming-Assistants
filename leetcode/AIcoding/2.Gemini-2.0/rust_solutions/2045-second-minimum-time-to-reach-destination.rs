use std::collections::VecDeque;

impl Solution {
    pub fn second_minimum(n: i32, edges: Vec<Vec<i32>>, time: i32, change: i32) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n + 1];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dist: Vec<Vec<i32>> = vec![vec![i32::MAX; 2]; n + 1];
        dist[1][0] = 0;

        let mut queue: VecDeque<(usize, i32)> = VecDeque::new();
        queue.push_back((1, 0));

        while let Some((u, d)) = queue.pop_front() {
            for &v in &adj[u] {
                if d + 1 < dist[v][0] {
                    dist[v][0] = d + 1;
                    queue.push_back((v, d + 1));
                } else if d + 1 > dist[v][0] && d + 1 < dist[v][1] {
                    dist[v][1] = d + 1;
                    queue.push_back((v, d + 1));
                }
            }
        }

        let mut current_time = 0;
        for _ in 0..dist[n][1] {
            if (current_time / change) % 2 == 1 {
                current_time = (current_time / change + 1) * change;
            }
            current_time += time;
        }

        current_time
    }
}