impl Solution {
    pub fn smallest_distance_pair(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let (mut left, mut right) = (0, nums.last().unwrap() - nums[0]);

        while left < right {
            let mid = left + (right - left) / 2;
            if Self::count_pairs(&nums, mid) < k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }

    fn count_pairs(nums: &[i32], mid: i32) -> i32 {
        let mut count = 0;
        let mut j = 0;
        for i in 0..nums.len() {
            while j < nums.len() && nums[j] - nums[i] <= mid {
                j += 1;
            }
            count += (j - i - 1) as i32;
        }
        count
    }
}