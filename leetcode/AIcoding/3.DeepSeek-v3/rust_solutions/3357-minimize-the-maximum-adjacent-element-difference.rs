impl Solution {
    pub fn minimize_max(nums: Vec<i32>, p: i32) -> i32 {
        if p == 0 {
            return 0;
        }
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut left = 0;
        let mut right = nums[n - 1] - nums[0];

        while left < right {
            let mid = left + (right - left) / 2;
            if Self::count_pairs(&nums, mid) >= p {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        left
    }

    fn count_pairs(nums: &[i32], max_diff: i32) -> i32 {
        let mut count = 0;
        let mut i = 0;
        while i < nums.len() - 1 {
            if nums[i + 1] - nums[i] <= max_diff {
                count += 1;
                i += 2;
            } else {
                i += 1;
            }
        }
        count
    }
}