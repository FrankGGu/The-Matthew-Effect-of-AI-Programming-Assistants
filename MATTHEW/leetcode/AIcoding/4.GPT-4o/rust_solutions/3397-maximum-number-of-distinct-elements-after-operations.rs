impl Solution {
    pub fn maximum_distinct_elements(nums: Vec<i32>, k: i32) -> i32 {
        use std::collections::HashSet;

        let mut unique_elements = HashSet::new();
        let mut count = 0;

        for &num in &nums {
            if unique_elements.insert(num) {
                count += 1;
            }
        }

        let total_unique = unique_elements.len();
        let total_nums = nums.len();

        if k >= total_nums - total_unique {
            return total_unique + (k - (total_nums - total_unique)).min(total_nums - total_unique) as i32;
        }

        total_unique as i32
    }
}