impl Solution {
    pub fn min_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![0; n + 1];
        let mut count = vec![0; 100001];

        for i in 1..=n {
            count.fill(0);
            dp[i] = dp[i - 1] + 1;
            for j in (1..=i).rev() {
                count[nums[j - 1] as usize] += 1;
                let unique_count = count.iter().filter(|&&x| x > 0).count();
                dp[i] = dp[i].min(dp[j - 1] + unique_count + k - 1);
            }
        }
        dp[n]
    }
}