impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut result = 0;
        let mut count = 0;
        let mut freq = std::collections::HashMap::new();

        for i in 0..n {
            *freq.entry(nums[i]).or_insert(0) += 1;
            if freq[&nums[i]] == k {
                count += 1;
            }
            if freq[&nums[i]] > k {
                count -= 1;
            }
            result += count;
        }

        result
    }
}