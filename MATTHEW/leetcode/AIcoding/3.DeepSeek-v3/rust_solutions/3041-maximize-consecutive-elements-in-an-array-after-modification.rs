impl Solution {
    pub fn max_num_after_moving_consecutive_elements(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let n = nums.len();
        let mut max_consec = 1;
        let mut current_consec = 1;

        for i in 1..n {
            if nums[i] == nums[i - 1] + 1 {
                current_consec += 1;
                max_consec = max_consec.max(current_consec);
            } else if nums[i] == nums[i - 1] {
                continue;
            } else {
                current_consec = 1;
            }
        }

        max_consec
    }
}