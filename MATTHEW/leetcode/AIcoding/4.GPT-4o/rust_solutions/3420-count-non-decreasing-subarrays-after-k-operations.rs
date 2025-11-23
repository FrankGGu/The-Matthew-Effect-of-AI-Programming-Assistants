impl Solution {
    pub fn count_non_decreasing_subarrays(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut res = 0;
        let mut left = 0;
        let mut right = 0;
        let mut counts = vec![0; n + 1];

        for i in 0..n {
            if i > 0 && nums[i] < nums[i - 1] {
                left = i;
            }
            while right < n && counts[nums[right] as usize] < k {
                counts[nums[right] as usize] += 1;
                right += 1;
            }
            res += (right - left) as i32;
            counts[nums[i] as usize] -= 1;
        }
        res
    }
}