impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![0; 4]; n + 1];

        for i in 1..=n {
            for j in 1..=3 {
                let cost = if nums[i - 1] != j as i32 { 1 } else { 0 };
                dp[i][j] = (1..=j).map(|k| dp[i - 1][k]).min().unwrap() + cost;
            }
        }

        *dp[n].iter().skip(1).min().unwrap()
    }
}