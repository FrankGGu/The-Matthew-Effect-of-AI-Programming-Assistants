impl Solution {
    pub fn number_of_subarrays(nums: Vec<i32>, pattern: Vec<i32>) -> i32 {
        let n = nums.len();
        let m = pattern.len();
        let mut count = 0;

        for i in 0..=n - m - 1 {
            let mut matched = true;
            for j in 0..m {
                if (nums[i + j + 1] > nums[i + j] && pattern[j] != 1) ||
                   (nums[i + j + 1] < nums[i + j] && pattern[j] != -1) ||
                   (nums[i + j + 1] == nums[i + j] && pattern[j] != 0) {
                    matched = false;
                    break;
                }
            }
            if matched {
                count += 1;
            }
        }

        count
    }
}