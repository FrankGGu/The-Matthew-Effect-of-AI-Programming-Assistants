impl Solution {
    pub fn count_complete_subarrays(nums: Vec<i32>) -> i32 {
        use std::collections::HashMap;
        let n = nums.len();
        let mut count = 0;
        let unique_count = nums.iter().collect::<std::collections::HashSet<_>>().len();
        let mut freq = HashMap::new();
        let mut left = 0;

        for right in 0..n {
            *freq.entry(nums[right]).or_insert(0) += 1;

            while freq.len() == unique_count {
                count += (n - right) as i32;
                let entry = freq.entry(nums[left]).or_insert(0);
                *entry -= 1;
                if *entry == 0 {
                    freq.remove(&nums[left]);
                }
                left += 1;
            }
        }
        count
    }
}