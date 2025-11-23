impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i64) -> i64 {
        let mut left = 0;
        let mut sum = 0;
        let mut res = 0;
        for right in 0..nums.len() {
            sum += nums[right] as i64;
            while sum * (right - left + 1) as i64 >= k {
                sum -= nums[left] as i64;
                left += 1;
            }
            res += (right - left + 1) as i64;
        }
        res
    }
}