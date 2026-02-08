use std::collections::HashMap;

pub fn tuple_same_product(nums: Vec<i32>) -> i32 {
    let mut product_count = HashMap::new();
    let mut count = 0;

    for i in 0..nums.len() {
        for j in i + 1..nums.len() {
            let product = nums[i] * nums[j];
            *product_count.entry(product).or_insert(0) += 1;
        }
    }

    for &c in product_count.values() {
        count += c * (c - 1);
    }

    count
}