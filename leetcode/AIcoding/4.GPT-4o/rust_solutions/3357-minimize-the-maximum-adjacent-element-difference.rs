impl Solution {
    pub fn minimize_max(nums: Vec<i32>, p: i32) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut left = 0;
        let mut right = *nums.last().unwrap() - *nums.first().unwrap();

        while left < right {
            let mid = left + (right - left) / 2;
            if Self::can_form_pairs(&nums, mid, p) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        left
    }

    fn can_form_pairs(nums: &[i32], max_diff: i32, p: i32) -> bool {
        let mut count = 0;
        let mut i = 0;
        while i < nums.len() - 1 {
            if nums[i + 1] - nums[i] <= max_diff {
                count += 1;
                i += 1; // skip next element as it is already paired
            }
            i += 1;
        }
        count >= p
    }
}