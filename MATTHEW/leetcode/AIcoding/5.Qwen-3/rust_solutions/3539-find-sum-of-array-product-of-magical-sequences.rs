impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn array_product_sum(nums: Vec<i32>) -> i32 {
        let mut memo = HashMap::new();
        Self::dp(&nums, 0, 1, &mut memo)
    }

    fn dp(nums: &Vec<i32>, index: usize, current_product: i32, memo: &mut HashMap<(usize, i32), i32>) -> i32 {
        if index == nums.len() {
            return 0;
        }
        let key = (index, current_product);
        if let Some(&val) = memo.get(&key) {
            return val;
        }

        let take = nums[index] * current_product + Self::dp(nums, index + 1, nums[index], memo);
        let not_take = Self::dp(nums, index + 1, current_product, memo);

        let result = take.max(not_take);
        memo.insert(key, result);
        result
    }
}
}