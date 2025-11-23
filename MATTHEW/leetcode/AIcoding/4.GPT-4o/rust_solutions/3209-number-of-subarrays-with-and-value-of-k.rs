impl Solution {
    pub fn count_subarrays_with_and_value(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let mut left = 0;
        let mut curr_and = !0;

        for right in 0..nums.len() {
            curr_and &= nums[right];
            while left <= right && curr_and < k {
                curr_and |= nums[left];
                left += 1;
            }
            if curr_and == k {
                count += (right - left + 1) as i32;
            }
        }
        count
    }
}