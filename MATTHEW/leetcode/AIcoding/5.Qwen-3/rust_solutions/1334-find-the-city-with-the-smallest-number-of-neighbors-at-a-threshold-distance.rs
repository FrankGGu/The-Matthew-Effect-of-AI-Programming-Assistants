impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_city(n: i32, edges: Vec<Vec<i32>>, distance_threshold: i32) -> i32 {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            graph[u].push((v, w));
            graph[v].push((u, w));
        }

        let mut min_neighbors = n;
        let mut result_city = 0;

        for start in 0..n {
            let mut dist = vec![i32::MAX; n];
            dist[start] = 0;
            let mut queue = VecDeque::new();
            queue.push_back(start);

            while let Some(u) = queue.pop_front() {
                for &(v, w) in &graph[u] {
                    if dist[v] > dist[u] + w {
                        dist[v] = dist[u] + w;
                        queue.push_back(v);
                    }
                }
            }

            let count = dist.iter().filter(|&&d| d <= distance_threshold).count();
            if count <= min_neighbors {
                min_neighbors = count;
                result_city = start as i32;
            }
        }

        result_city
    }
}
}