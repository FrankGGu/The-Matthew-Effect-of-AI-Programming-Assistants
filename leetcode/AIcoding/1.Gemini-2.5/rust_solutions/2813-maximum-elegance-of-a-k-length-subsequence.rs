use std::collections::{BinaryHeap, HashSet};
use std::cmp::Reverse;

impl Solution {
    pub fn find_maximum_elegance(items: Vec<Vec<i32>>, k: i32) -> i64 {
        let mut items: Vec<(i32, i32)> = items.into_iter().map(|v| (v[0], v[1])).collect();
        items.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let k_usize = k as usize;
        let mut current_profit: i64 = 0;
        let mut current_categories: HashSet<i32> = HashSet::new();
        let mut duplicate_profits: BinaryHeap<Reverse<i32>> = BinaryHeap::new();

        for i in 0..k_usize {
            let (profit, category) = items[i];
            current_profit += profit as i64;
            if !current_categories.insert(category) {
                duplicate_profits.push(Reverse(profit));
            }
        }

        let mut max_elegance: i64 = current_profit + (current_categories.len() as i64).pow(2);

        for i in k_usize..items.len() {
            let (profit_new, category_new) = items[i];

            if current_categories.contains(&category_new) {
                continue;
            }

            if let Some(Reverse(profit_old)) = duplicate_profits.pop() {
                current_profit = current_profit - (profit_old as i64) + (profit_new as i64);
                current_categories.insert(category_new);
                max_elegance = max_elegance.max(current_profit + (current_categories.len() as i64).pow(2));
            } else {
                break;
            }
        }

        max_elegance
    }
}