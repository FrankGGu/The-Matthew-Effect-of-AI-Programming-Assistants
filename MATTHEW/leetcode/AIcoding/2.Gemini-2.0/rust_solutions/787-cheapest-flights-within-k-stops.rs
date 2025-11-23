use std::collections::HashMap;

impl Solution {
    pub fn find_cheapest_price(n: i32, flights: Vec<Vec<i32>>, src: i32, dst: i32, k: i32) -> i32 {
        let mut adj: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();
        for flight in &flights {
            adj.entry(flight[0]).or_insert(Vec::new()).push((flight[1], flight[2]));
        }

        let mut dist: Vec<i32> = vec![i32::MAX; n as usize];
        dist[src as usize] = 0;

        let mut q: Vec<(i32, i32)> = Vec::new();
        q.push((src, 0));

        for _ in 0..=k {
            let mut temp_q: Vec<(i32, i32)> = Vec::new();
            for (u, price) in q {
                if let Some(neighbors) = adj.get(&u) {
                    for &(v, p) in neighbors {
                        if price + p < dist[v as usize] {
                            dist[v as usize] = price + p;
                            temp_q.push((v, dist[v as usize]));
                        }
                    }
                }
            }
            q = temp_q;
        }

        if dist[dst as usize] == i32::MAX {
            -1
        } else {
            dist[dst as usize]
        }
    }
}