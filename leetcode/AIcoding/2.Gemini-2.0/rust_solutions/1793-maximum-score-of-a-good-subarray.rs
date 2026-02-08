impl Solution {
    pub fn maximum_score(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut left = k;
        let mut right = k;
        let mut min_val = nums[k];
        let mut max_score = min_val;

        while left > 0 || right < n - 1 {
            if right < n - 1 && (left == 0 || nums[right + 1] > nums[left - 1]) {
                right += 1;
                min_val = min_val.min(nums[right]);
            } else {
                left -= 1;
                min_val = min_val.min(nums[left]);
            }
            max_score = max_score.max(min_val * (right - left + 1) as i32);
        }

        max_score
    }
}