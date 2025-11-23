impl Solution {
    pub fn max_sum_with_k_elements(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut k = k;
        let mut sum = 0;
        let mut n = nums.len();
        while k > 0 && n > 0 {
            sum += nums[n - 1];
            sum += nums[n - 1] - 1;
            nums[n - 1] += 1;
            n -= 1;
            k -= 1;
        }
        sum
    }
}