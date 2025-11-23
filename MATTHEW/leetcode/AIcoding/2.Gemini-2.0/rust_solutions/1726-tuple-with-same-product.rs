use std::collections::HashMap;

impl Solution {
    pub fn tuple_same_product(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        let mut product_counts: HashMap<i32, i32> = HashMap::new();

        for i in 0..n {
            for j in i + 1..n {
                let product = nums[i] * nums[j];
                *product_counts.entry(product).or_insert(0) += 1;
            }
        }

        for &num_pairs in product_counts.values() {
            count += num_pairs * (num_pairs - 1) / 2;
        }

        count * 8
    }
}

struct Solution;