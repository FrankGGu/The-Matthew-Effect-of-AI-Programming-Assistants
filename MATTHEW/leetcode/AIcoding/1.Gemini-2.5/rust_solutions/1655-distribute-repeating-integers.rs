use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn distribute_repeating_integers(nums: Vec<i32>, quantity: Vec<i32>) -> bool {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut item_counts: Vec<i32> = counts.values().cloned().collect();

        let mut quantity = quantity;
        quantity.sort_by(|a, b| b.cmp(a));

        let mut memo: HashMap<(usize, Vec<i32>), bool> = HashMap::new();

        Self::can_distribute_recursive(0, &mut item_counts, &quantity, &mut memo)
    }

    fn can_distribute_recursive(
        customer_idx: usize,
        current_item_counts: &mut Vec<i32>,
        quantity: &Vec<i32>,
        memo: &mut HashMap<(usize, Vec<i32>), bool>,
    ) -> bool {
        if customer_idx == quantity.len() {
            return true;
        }

        let mut canonical_counts = current_item_counts.clone();
        canonical_counts.sort_unstable();
        let current_state = (customer_idx, canonical_counts);

        if let Some(&result) = memo.get(&current_state) {
            return result;
        }

        let current_customer_demand = quantity[customer_idx];

        for i in 0..current_item_counts.len() {
            if current_item_counts[i] >= current_customer_demand {
                current_item_counts[i] -= current_customer_demand;

                if Self::can_distribute_recursive(
                    customer_idx + 1,
                    current_item_counts,
                    quantity,
                    memo,
                ) {
                    memo.insert(current_state, true);
                    return true;
                }

                current_item_counts[i] += current_customer_demand;
            }
        }

        memo.insert(current_state, false);
        false
    }
}