struct Solution;

impl Solution {
    pub fn maximum_sum_after_removal(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix = vec![0; n];
        let mut suffix = vec![0; n];

        for i in 1..n {
            prefix[i] = prefix[i - 1].max(nums[i - 1]);
        }

        for i in (0..n - 1).rev() {
            suffix[i] = suffix[i + 1].max(nums[i + 1]);
        }

        let mut max_sum = 0;
        for i in 0..n {
            let left = if i > 0 { prefix[i - 1] } else { 0 };
            let right = if i < n - 1 { suffix[i + 1] } else { 0 };
            max_sum = max_sum.max(left + right);
        }

        max_sum
    }
}