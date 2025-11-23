impl Solution {
    pub fn num_subarray_product_less_than_k(nums: Vec<i32>, k: i32) -> i32 {
        if k <= 1 {
            return 0;
        }
        let mut product = 1;
        let mut count = 0;
        let mut left = 0;

        for right in 0..nums.len() {
            product *= nums[right];
            while product >= k {
                product /= nums[left];
                left += 1;
            }
            count += right - left + 1;
        }
        count
    }
}