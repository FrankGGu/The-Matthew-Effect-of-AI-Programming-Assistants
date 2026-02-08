use std::collections::HashMap;

impl Solution {
    pub fn find_lhs(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for num in nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut longest = 0;
        for &num in count.keys() {
            if let Some(&next_count) = count.get(&(num + 1)) {
                longest = longest.max(count[&num] + next_count);
            }
        }

        longest
    }
}