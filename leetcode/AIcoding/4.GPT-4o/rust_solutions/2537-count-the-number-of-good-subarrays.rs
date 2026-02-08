impl Solution {
    pub fn count_good_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        use std::collections::HashMap;
        let mut count = 0;
        let mut prefix_count = 0;
        let mut freq = HashMap::new();
        freq.insert(0, 1);

        for &num in &nums {
            prefix_count += num;
            if let Some(&v) = freq.get(&(prefix_count - k)) {
                count += v;
            }
            *freq.entry(prefix_count).or_insert(0) += 1;
        }

        count
    }
}