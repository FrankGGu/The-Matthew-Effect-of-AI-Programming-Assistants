impl Solution {
    pub fn max_product(nums: Vec<i32>) -> i32 {
        let mut max_prod = nums[0];
        let mut min_prod = nums[0];
        let mut result = nums[0];

        for &num in &nums[1..] {
            if num < 0 {
                std::mem::swap(&mut max_prod, &mut min_prod);
            }
            max_prod = max_prod.max(num);
            min_prod = min_prod.min(num);
            max_prod = max_prod.max(max_prod * num);
            min_prod = min_prod.min(min_prod * num);
            result = result.max(max_prod);
        }

        result
    }
}