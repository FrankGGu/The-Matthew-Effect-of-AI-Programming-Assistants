use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn find_category_recommendation_pairs(transactions: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut user_categories: HashMap<i32, HashSet<i32>> = HashMap::new();

        for transaction in transactions {
            let user_id = transaction[0];
            let category_id = transaction[1];
            user_categories.entry(user_id).or_default().insert(category_id);
        }

        let mut pair_counts: HashMap<(i32, i32), i32> = HashMap::new();

        for categories in user_categories.values() {
            let mut sorted_categories: Vec<i32> = categories.iter().cloned().collect();
            sorted_categories.sort_unstable();

            for i in 0..sorted_categories.len() {
                for j in (i + 1)..sorted_categories.len() {
                    let c1 = sorted_categories[i];
                    let c2 = sorted_categories[j];
                    *pair_counts.entry((c1, c2)).or_default() += 1;
                }
            }
        }

        let mut result: Vec<Vec<i32>> = Vec::new();
        for ((c1, c2), count) in pair_counts {
            result.push(vec![c1, c2, count]);
        }

        result.sort_unstable_by(|a, b| {
            a[0].cmp(&b[0])
                .then_with(|| a[1].cmp(&b[1]))
        });

        result
    }
}