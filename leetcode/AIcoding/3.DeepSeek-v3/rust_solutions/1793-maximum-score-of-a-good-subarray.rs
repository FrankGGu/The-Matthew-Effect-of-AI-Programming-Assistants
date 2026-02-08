impl Solution {
    pub fn maximum_score(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut left = k;
        let mut right = k;
        let mut min_val = nums[k];
        let mut max_score = min_val;

        while left > 0 || right < n - 1 {
            if left == 0 {
                right += 1;
            } else if right == n - 1 {
                left -= 1;
            } else if nums[left - 1] > nums[right + 1] {
                left -= 1;
            } else {
                right += 1;
            }
            min_val = min_val.min(nums[left]).min(nums[right]);
            max_score = max_score.max(min_val * (right - left + 1) as i32);
        }

        max_score
    }
}