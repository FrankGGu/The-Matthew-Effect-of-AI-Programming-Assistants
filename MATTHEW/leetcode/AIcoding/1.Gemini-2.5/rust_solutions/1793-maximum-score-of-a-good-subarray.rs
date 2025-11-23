impl Solution {
    pub fn max_score(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;

        let mut left = k;
        let mut right = k;
        let mut min_val = nums[k];
        let mut max_score = min_val;

        while left > 0 || right < n - 1 {
            if left == 0 {
                // Cannot expand left, must expand right
                right += 1;
            } else if right == n - 1 {
                // Cannot expand right, must expand left
                left -= 1;
            } else if nums[left - 1] < nums[right + 1] {
                // Expand to the right if the right neighbor is potentially larger
                right += 1;
            } else {
                // Expand to the left if the left neighbor is potentially larger or equal
                left -= 1;
            }

            // Update the minimum value for the current subarray [left, right]
            min_val = min_val.min(nums[left]).min(nums[right]);

            // Calculate the score for the current subarray and update max_score
            max_score = max_score.max(min_val * (right - left + 1) as i32);
        }

        max_score
    }
}