use std::collections::VecDeque;
use std::cmp::min;

impl Solution {
    pub fn find_cheapest_price(n: i32, flights: Vec<Vec<i32>>, src: i32, dst: i32, k: i32) -> i32 {
        let n = n as usize;
        let src = src as usize;
        let dst = dst as usize;
        let k = k as usize;

        let mut graph = vec![vec![]; n];
        for flight in flights {
            let from = flight[0] as usize;
            let to = flight[1] as usize;
            let price = flight[2];
            graph[from].push((to, price));
        }

        let mut dist = vec![std::i32::MAX; n];
        dist[src] = 0;

        let mut queue = VecDeque::new();
        queue.push_back((src, 0));

        let mut stops = 0;

        while !queue.is_empty() && stops <= k {
            let len = queue.len();
            for _ in 0..len {
                if let Some((current, cost)) = queue.pop_front() {
                    for &(neighbor, price) in &graph[current] {
                        if cost + price < dist[neighbor] {
                            dist[neighbor] = cost + price;
                            queue.push_back((neighbor, dist[neighbor]));
                        }
                    }
                }
            }
            stops += 1;
        }

        if dist[dst] == std::i32::MAX {
            -1
        } else {
            dist[dst]
        }
    }
}