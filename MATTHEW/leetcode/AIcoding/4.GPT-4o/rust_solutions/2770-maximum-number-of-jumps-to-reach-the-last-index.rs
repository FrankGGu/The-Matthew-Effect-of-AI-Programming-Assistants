impl Solution {
    pub fn max_jumps(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        let mut stack = vec![];

        for i in (0..n).rev() {
            while let Some(&j) = stack.last() {
                if nums[j] < nums[i] {
                    break;
                }
                stack.pop();
            }

            if let Some(&j) = stack.last() {
                dp[i] = dp[j] + 1;
            }

            stack.push(i);
        }

        *dp.iter().max().unwrap_or(&0)
    }
}