use std::collections::HashMap;

impl Solution {
    pub fn count_triplets(nums: Vec<i32>) -> i64 {
        let mut count = 0;
        let n = nums.len();
        let mut freq: HashMap<i32, i32> = HashMap::new();

        for &num in &nums {
            *freq.entry(num).or_insert(0) += 1;
        }

        for i in 0..n {
            for j in i + 1..n {
                let xor_val = nums[i] ^ nums[j];
                if let Some(&f) = freq.get(&xor_val) {
                    count += f as i64;
                }
            }
        }

        count
    }
}