use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_recommendation_pairs(orders: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut pair_counts: HashMap<(i32, i32), i32> = HashMap::new();

        for mut order in orders {
            order.sort_unstable();
            order.dedup();

            for i in 0..order.len() {
                for j in (i + 1)..order.len() {
                    let p1 = order[i];
                    let p2 = order[j];
                    *pair_counts.entry((p1, p2)).or_insert(0) += 1;
                }
            }
        }

        let mut result: Vec<Vec<i32>> = Vec::new();
        for ((p1, p2), count) in pair_counts {
            result.push(vec![p1, p2, count]);
        }

        result
    }
}