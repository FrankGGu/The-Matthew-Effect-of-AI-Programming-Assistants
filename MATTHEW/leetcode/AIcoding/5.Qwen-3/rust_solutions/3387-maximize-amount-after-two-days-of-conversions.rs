impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_amount_after_two_days(conversions: Vec<Vec<i32>>, start: i32) -> i32 {
        let mut graph = HashMap::new();
        for conv in conversions {
            let from = conv[0];
            let to = conv[1];
            let rate = conv[2];
            graph.entry(from).or_insert_with(Vec::new).push((to, rate));
        }

        let mut day1 = HashMap::new();
        day1.insert(start, 1);

        for (from, rates) in &graph {
            for (to, rate) in rates {
                if let Some(&amount) = day1.get(from) {
                    day1.entry(*to).or_insert(0);
                    *day1.get_mut(to).unwrap() += amount * *rate;
                }
            }
        }

        let mut day2 = HashMap::new();
        for (from, amount) in &day1 {
            for (to, rate) in graph.get(from).into_iter().flatten() {
                day2.entry(*to).or_insert(0);
                *day2.get_mut(to).unwrap() += *amount * *rate;
            }
        }

        day2.into_values().max().unwrap_or(0)
    }
}
}