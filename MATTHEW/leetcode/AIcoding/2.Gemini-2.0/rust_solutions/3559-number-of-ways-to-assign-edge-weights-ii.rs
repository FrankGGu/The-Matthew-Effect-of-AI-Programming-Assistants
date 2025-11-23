use std::collections::VecDeque;

impl Solution {
    pub fn number_of_ways(n: i32, edges: Vec<Vec<i32>>, discount: i32) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize - 1;
            let v = edge[1] as usize - 1;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut dist: Vec<i64> = vec![i64::MAX; n];
        dist[0] = 0;
        let mut pq: VecDeque<usize> = VecDeque::new();
        pq.push_back(0);

        while let Some(u) = pq.pop_front() {
            for &(v, w) in &adj[u] {
                if dist[u] + w as i64 < dist[v] {
                    dist[v] = dist[u] + w as i64;
                    pq.push_back(v);
                }
            }
        }

        if dist[n - 1] == i64::MAX {
            return 0;
        }

        let mut ways = 0i64;
        let mut total_edges = 0i64;

        for i in 0..edges.len() {
            let u = edges[i][0] as usize - 1;
            let v = edges[i][1] as usize - 1;
            let w = edges[i][2];

            let mut possible_weights = 0i64;

            if dist[u] + 1 <= dist[v] {
                possible_weights += discount as i64;
            }
            if dist[v] + 1 <= dist[u] {
                possible_weights += discount as i64;
            }

            if dist[u] + w as i64 == dist[v] {
                possible_weights += 1;
            }
            if dist[v] + w as i64 == dist[u] {
                possible_weights += 1;
            }

            if possible_weights == 0 {
                return 0;
            }

            if total_edges == 0 {
                ways = possible_weights;
            } else {
                ways = (ways * possible_weights) % 1000000007;
            }
            total_edges += 1;
        }

        ways
    }
}