impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i64) -> i64 {
        let mut count = 0;
        let mut left = 0;
        let mut current_sum = 0;
        for right in 0..nums.len() {
            current_sum += nums[right] as i64;
            while current_sum * (right - left + 1) as i64 >= k && left <= right {
                current_sum -= nums[left] as i64;
                left += 1;
            }
            count += (right - left + 1) as i64;
        }
        count
    }
}