use std::collections::HashMap;
use std::cmp::min;

impl Solution {
    pub fn min_cost_to_make_equal(basket1: Vec<i32>, basket2: Vec<i32>) -> i64 {
        let mut total_counts: HashMap<i32, i32> = HashMap::new();
        let mut min_val = i32::MAX;

        for &fruit in &basket1 {
            *total_counts.entry(fruit).or_insert(0) += 1;
            min_val = min(min_val, fruit);
        }
        for &fruit in &basket2 {
            *total_counts.entry(fruit).or_insert(0) += 1;
            min_val = min(min_val, fruit);
        }

        for (&fruit, &count) in &total_counts {
            if count % 2 != 0 {
                return -1;
            }
        }

        let mut b1_fruit_counts: HashMap<i32, i32> = HashMap::new();
        for &fruit in &basket1 {
            *b1_fruit_counts.entry(fruit).or_insert(0) += 1;
        }

        let mut all_misplaced_fruits: Vec<i32> = Vec::new();

        for (&fruit, &total_count) in &total_counts {
            let target_count = total_count / 2;
            let current_count_in_b1 = *b1_fruit_counts.get(&fruit).unwrap_or(&0);

            if current_count_in_b1 > target_count {
                let num_excess = current_count_in_b1 - target_count;
                for _ in 0..num_excess {
                    all_misplaced_fruits.push(fruit);
                }
            }
        }

        all_misplaced_fruits.sort_unstable();

        let mut cost: i64 = 0;
        let num_moves = all_misplaced_fruits.len() / 2;

        for i in 0..num_moves {
            cost += min(all_misplaced_fruits[i] as i64, 2 * min_val as i64);
        }

        cost
    }
}