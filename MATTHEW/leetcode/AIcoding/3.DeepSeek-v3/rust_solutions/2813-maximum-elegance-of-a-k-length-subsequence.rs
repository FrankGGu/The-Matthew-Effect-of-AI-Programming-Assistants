use std::collections::{HashSet, BinaryHeap};

impl Solution {
    pub fn find_maximum_elegance(items: Vec<Vec<i32>>, k: i32) -> i64 {
        let k = k as usize;
        let mut items = items;
        items.sort_by(|a, b| b[0].cmp(&a[0]));

        let mut res = 0;
        let mut sum = 0;
        let mut unique_categories = HashSet::new();
        let mut duplicate_items = BinaryHeap::new();

        for i in 0..k {
            let profit = items[i][0] as i64;
            let category = items[i][1];
            sum += profit;
            if unique_categories.contains(&category) {
                duplicate_items.push(-profit);
            } else {
                unique_categories.insert(category);
            }
        }

        res = sum + (unique_categories.len() as i64) * (unique_categories.len() as i64);

        for i in k..items.len() {
            let category = items[i][1];
            if !unique_categories.contains(&category) {
                if let Some(min_profit) = duplicate_items.pop() {
                    sum += (items[i][0] as i64) + min_profit;
                    unique_categories.insert(category);
                    let current_elegance = sum + (unique_categories.len() as i64) * (unique_categories.len() as i64);
                    if current_elegance > res {
                        res = current_elegance;
                    }
                }
            }
        }

        res
    }
}