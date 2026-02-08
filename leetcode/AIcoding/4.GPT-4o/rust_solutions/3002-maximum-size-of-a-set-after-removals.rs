impl Solution {
    pub fn maximum_size(nums: Vec<i32>, max_removals: i32) -> i32 {
        let mut left = 1;
        let mut right = nums.len() as i32;
        let mut nums = nums;
        nums.sort_unstable();

        while left < right {
            let mid = (left + right + 1) / 2;
            if Self::can_remove(&nums, mid, max_removals) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        left
    }

    fn can_remove(nums: &[i32], size: i32, max_removals: i32) -> bool {
        let mut removals = 0;
        for i in 0..size as usize {
            if nums[i] > size {
                removals += 1;
            }
            if removals > max_removals {
                return false;
            }
        }
        true
    }
}