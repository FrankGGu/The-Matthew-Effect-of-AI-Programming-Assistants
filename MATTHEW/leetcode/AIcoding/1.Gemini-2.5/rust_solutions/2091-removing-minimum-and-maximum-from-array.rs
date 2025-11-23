impl Solution {
    pub fn minimum_deletions(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        if n <= 2 {
            return n as i32;
        }

        let mut min_val = nums[0];
        let mut min_idx = 0;
        let mut max_val = nums[0];
        let mut max_idx = 0;

        for i in 0..n {
            if nums[i] < min_val {
                min_val = nums[i];
                min_idx = i;
            }
            if nums[i] > max_val {
                max_val = nums[i];
                max_idx = i;
            }
        }

        let (idx1, idx2) = if min_idx < max_idx {
            (min_idx, max_idx)
        } else {
            (max_idx, min_idx)
        };

        let option1 = (idx2 + 1) as i32;
        let option2 = (n - idx1) as i32;
        let option3 = (idx1 + 1 + n - idx2) as i32;

        option1.min(option2).min(option3)
    }
}