struct Solution;

impl Solution {
    pub fn find_x_sum_of_all_k_long_subarrays(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let n = nums.len();
        let k_usize = k as usize;

        if k_usize == 0 || k_usize > n {
            return Vec::new();
        }

        let mut result: Vec<i32> = Vec::with_capacity(n - k_usize + 1);
        let mut current_sum: i32 = 0;

        for i in 0..k_usize {
            current_sum += nums[i];
        }
        result.push(current_sum);

        for i in k_usize..n {
            current_sum -= nums[i - k_usize];
            current_sum += nums[i];
            result.push(current_sum);
        }

        result
    }
}