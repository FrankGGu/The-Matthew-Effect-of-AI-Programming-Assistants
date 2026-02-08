impl Solution {
    pub fn can_distribute(nums: Vec<i32>, quantity: Vec<i32>) -> bool {
        use std::collections::HashMap;

        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &num in &nums {
            *counts.entry(num).or_insert(0) += 1;
        }

        let mut freq: Vec<i32> = counts.values().cloned().collect();
        freq.sort_by(|a, b| b.cmp(a));

        let mut sorted_quantity = quantity.clone();
        sorted_quantity.sort_by(|a, b| b.cmp(a));

        fn backtrack(freq: &mut Vec<i32>, quantity: &Vec<i32>, idx: usize) -> bool {
            if idx == quantity.len() {
                return true;
            }

            for i in 0..freq.len() {
                if freq[i] >= quantity[idx] {
                    freq[i] -= quantity[idx];
                    if backtrack(freq, quantity, idx + 1) {
                        return true;
                    }
                    freq[i] += quantity[idx];
                }
            }

            false
        }

        backtrack(&mut freq, &sorted_quantity, 0)
    }
}