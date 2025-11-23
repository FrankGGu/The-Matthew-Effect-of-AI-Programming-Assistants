use std::collections::HashMap;

impl Solution {
    pub fn minimum_cost(
        source: String,
        target: String,
        original: Vec<String>,
        changed: Vec<String>,
        cost: Vec<i32>,
    ) -> i64 {
        let mut graph = HashMap::new();
        for i in 0..original.len() {
            let orig = &original[i];
            let change = &changed[i];
            let c = cost[i] as i64;
            let entry = graph.entry(orig.clone()).or_insert(HashMap::new());
            entry.insert(change.clone(), c.min(*entry.get(change).unwrap_or(&i64::MAX)));
        }

        let mut dist = HashMap::new();
        for orig in original.iter().chain(changed.iter()) {
            let mut pq = std::collections::BinaryHeap::new();
            let mut local_dist = HashMap::new();
            pq.push(std::cmp::Reverse((0, orig.clone())));
            local_dist.insert(orig.clone(), 0);
            while let Some(std::cmp::Reverse((d, u))) = pq.pop() {
                if d > *local_dist.get(&u).unwrap_or(&i64::MAX) {
                    continue;
                }
                if let Some(edges) = graph.get(&u) {
                    for (v, cost) in edges {
                        let new_dist = d + cost;
                        if new_dist < *local_dist.get(v).unwrap_or(&i64::MAX) {
                            local_dist.insert(v.clone(), new_dist);
                            pq.push(std::cmp::Reverse((new_dist, v.clone())));
                        }
                    }
                }
            }
            dist.insert(orig.clone(), local_dist);
        }

        let n = source.len();
        let mut dp = vec![i64::MAX; n + 1];
        dp[0] = 0;
        let source_chars: Vec<char> = source.chars().collect();
        let target_chars: Vec<char> = target.chars().collect();

        for i in 0..n {
            if dp[i] == i64::MAX {
                continue;
            }
            if source_chars[i] == target_chars[i] {
                dp[i + 1] = dp[i + 1].min(dp[i]);
            }
            for j in i..n {
                let s_sub: String = source_chars[i..=j].iter().collect();
                let t_sub: String = target_chars[i..=j].iter().collect();
                if let Some(d) = dist.get(&s_sub).and_then(|m| m.get(&t_sub)) {
                    dp[j + 1] = dp[j + 1].min(dp[i] + *d);
                }
            }
        }

        if dp[n] == i64::MAX {
            -1
        } else {
            dp[n]
        }
    }
}