use std::collections::HashMap;

impl Solution {
    pub fn tuple_same_product(nums: Vec<i32>) -> i32 {
        let mut product_counts = HashMap::new();
        let n = nums.len();

        for i in 0..n {
            for j in i + 1..n {
                let product = nums[i] * nums[j];
                *product_counts.entry(product).or_insert(0) += 1;
            }
        }

        let mut result = 0;
        for &count in product_counts.values() {
            if count >= 2 {
                result += count * (count - 1) / 2 * 8;
            }
        }

        result
    }
}