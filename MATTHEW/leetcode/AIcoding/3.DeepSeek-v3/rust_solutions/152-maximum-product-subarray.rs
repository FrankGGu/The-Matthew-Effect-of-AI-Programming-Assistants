impl Solution {
    pub fn max_product(nums: Vec<i32>) -> i32 {
        let mut max_prod = nums[0];
        let mut min_prod = nums[0];
        let mut result = nums[0];

        for &num in nums.iter().skip(1) {
            if num < 0 {
                std::mem::swap(&mut max_prod, &mut min_prod);
            }

            max_prod = num.max(max_prod * num);
            min_prod = num.min(min_prod * num);

            result = result.max(max_prod);
        }

        result
    }
}