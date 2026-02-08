impl Solution {
    pub fn count_subarrays(nums: Vec<i32>, k: i64) -> i64 {
        let n = nums.len();
        let mut count: i64 = 0;
        let mut current_sum: i64 = 0;
        let mut left: usize = 0;

        for right in 0..n {
            current_sum += nums[right] as i64;

            // While the current window's score is not less than k, shrink the window from the left.
            // The score is current_sum * window_length.
            // window_length is (right - left + 1).
            while current_sum * (right - left + 1) as i64 >= k {
                current_sum -= nums[left] as i64;
                left += 1;
            }

            // At this point, the window nums[left..right] has a score less than k.
            // All subarrays ending at 'right' and starting from 'left' up to 'right'
            // (i.e., nums[left..right], nums[left+1..right], ..., nums[right..right])
            // will also have a score less than k because removing elements from the start
            // or shortening the window will only decrease or keep the same sum and length,
            // thus decreasing or keeping the same score.
            // The number of such valid subarrays is (right - left + 1).
            // We use (right as i64 - left as i64 + 1).max(0) to correctly handle
            // cases where 'left' might have advanced past 'right' (meaning no valid subarray).
            count += (right as i64 - left as i64 + 1).max(0);
        }

        count
    }
}