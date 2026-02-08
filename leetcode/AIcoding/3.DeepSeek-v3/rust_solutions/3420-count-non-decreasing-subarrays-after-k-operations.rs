impl Solution {
    pub fn count_non_decreasing_subarrays(nums: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let n = nums.len();
        let mut nums = nums;
        let mut res = 0i64;
        let mut prefix = vec![0; n + 1];

        for _ in 0..k {
            let mut stack = Vec::new();
            let mut dp = vec![1; n];
            for i in 0..n {
                while let Some(&j) = stack.last() {
                    if nums[j] <= nums[i] {
                        break;
                    }
                    stack.pop();
                }
                if let Some(&j) = stack.last() {
                    dp[i] += dp[j];
                }
                stack.push(i);
            }
            prefix[0] = 0;
            for i in 0..n {
                prefix[i + 1] = prefix[i] + dp[i] as i64;
            }
            res += prefix[n];

            let min_pos = nums.iter().enumerate().min_by_key(|&(_, &val)| val).unwrap().0;
            nums[min_pos] += 1;
        }

        res
    }
}