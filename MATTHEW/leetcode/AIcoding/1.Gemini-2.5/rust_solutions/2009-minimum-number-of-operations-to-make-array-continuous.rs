impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len() as i32;
        let mut nums = nums;
        nums.sort();
        nums.dedup(); 

        let m = nums.len();

        let mut max_kept = 0;
        let mut right = 0;

        for left in 0..m {
            let target_end = nums[left] + n - 1;

            while right < m && nums[right] <= target_end {
                right += 1;
            }

            max_kept = max_kept.max(right - left);
        }

        n - max_kept as i32
    }
}