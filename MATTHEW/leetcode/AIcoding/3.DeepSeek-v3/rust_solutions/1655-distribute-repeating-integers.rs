impl Solution {
    pub fn can_distribute(nums: Vec<i32>, quantity: Vec<i32>) -> bool {
        use std::collections::HashMap;

        let mut freq = HashMap::new();
        for num in nums {
            *freq.entry(num).or_insert(0) += 1;
        }
        let mut counts: Vec<i32> = freq.values().cloned().collect();
        counts.sort_unstable_by(|a, b| b.cmp(a));
        let mut quantity = quantity;
        quantity.sort_unstable_by(|a, b| b.cmp(a));

        Self::backtrack(&mut counts, &quantity, 0)
    }

    fn backtrack(counts: &mut Vec<i32>, quantity: &[i32], idx: usize) -> bool {
        if idx == quantity.len() {
            return true;
        }

        for i in 0..counts.len() {
            if counts[i] >= quantity[idx] {
                counts[i] -= quantity[idx];
                if Self::backtrack(counts, quantity, idx + 1) {
                    return true;
                }
                counts[i] += quantity[idx];
            }
        }

        false
    }
}