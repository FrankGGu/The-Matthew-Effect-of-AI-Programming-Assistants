impl Solution {
    pub fn beautiful_subarrays(nums: Vec<i32>) -> i32 {
        use std::collections::HashMap;

        let mut count = 0;
        let mut prefix_xor = 0;
        let mut freq = HashMap::new();
        freq.insert(0, 1);

        for num in nums {
            prefix_xor ^= num;
            count += freq.get(&(prefix_xor ^ 1)).unwrap_or(&0);
            *freq.entry(prefix_xor).or_insert(0) += 1;
        }

        count
    }
}