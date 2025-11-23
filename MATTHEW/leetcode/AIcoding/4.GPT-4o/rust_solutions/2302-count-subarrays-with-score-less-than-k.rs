impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut sum = 0;
        let mut left = 0;

        for right in 0..nums.len() {
            sum += nums[right];
            while sum >= k {
                sum -= nums[left];
                left += 1;
            }
            count += (right - left + 1) as i32;
        }

        count
    }
}