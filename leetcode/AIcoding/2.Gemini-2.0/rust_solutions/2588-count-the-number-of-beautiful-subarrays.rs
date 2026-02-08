impl Solution {
    pub fn count_beautiful_subarrays(nums: Vec<i32>) -> i64 {
        let mut count = 0;
        let mut prefix_xor = 0;
        let mut freq = std::collections::HashMap::new();
        freq.insert(0, 1);

        for &num in &nums {
            prefix_xor ^= num;
            if let Some(&f) = freq.get(&prefix_xor) {
                count += f;
            }
            *freq.entry(prefix_xor).or_insert(0) += 1;
        }

        count
    }
}