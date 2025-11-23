impl Solution {

use std::collections::{VecDeque, HashMap};

impl Solution {
    pub fn find_cheapest_price(mut n: i32, mut flights: Vec<Vec<i32>>, mut src: i32, mut dst: i32, k: i32) -> i32 {
        let mut graph = HashMap::new();
        for flight in &flights {
            let (from, to, price) = (flight[0], flight[1], flight[2]);
            graph.entry(from).or_insert_with(Vec::new).push((to, price));
        }

        let mut dist = vec![i32::MAX; n as usize];
        dist[src as usize] = 0;

        let mut queue = VecDeque::new();
        queue.push_back((src, 0));

        for _ in 0..=k {
            let size = queue.len();
            for _ in 0..size {
                let (current, current_cost) = queue.pop_front().unwrap();
                if let Some(adj) = graph.get(&current) {
                    for &(next, price) in adj {
                        if dist[next as usize] > current_cost + price {
                            dist[next as usize] = current_cost + price;
                            queue.push_back((next, dist[next as usize]));
                        }
                    }
                }
            }
        }

        if dist[dst as usize] == i32::MAX {
            -1
        } else {
            dist[dst as usize]
        }
    }
}
}