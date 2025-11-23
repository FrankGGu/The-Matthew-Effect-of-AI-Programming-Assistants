pub struct Solution {}

impl Solution {
    pub fn max_product(nums: Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }

        let mut max_prod = nums[0];
        let mut min_prod = nums[0];
        let mut result = nums[0];

        for i in 1..nums.len() {
            let num = nums[i];
            if num < 0 {
                std::mem::swap(&mut max_prod, &mut min_prod);
            }
            max_prod = std::cmp::max(num, max_prod * num);
            min_prod = std::cmp::min(num, min_prod * num);
            result = std::cmp::max(result, max_prod);
        }

        result
    }
}