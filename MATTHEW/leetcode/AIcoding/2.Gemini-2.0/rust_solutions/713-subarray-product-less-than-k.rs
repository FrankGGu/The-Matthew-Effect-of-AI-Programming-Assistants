impl Solution {
    pub fn num_subarray_product_less_than_k(nums: Vec<i32>, k: i32) -> i32 {
        if k <= 1 {
            return 0;
        }

        let mut prod: i32 = 1;
        let mut left: usize = 0;
        let mut count: i32 = 0;

        for right in 0..nums.len() {
            prod *= nums[right];
            while prod >= k {
                prod /= nums[left];
                left += 1;
            }
            count += (right - left + 1) as i32;
        }

        count
    }
}