impl Solution {
    pub fn delete_and_earn(nums: Vec<i32>) -> i32 {
        let mut counts = std::collections::HashMap::new();
        let mut max_num = 0;
        for &num in &nums {
            *counts.entry(num).or_insert(0) += num;
            max_num = max_num.max(num);
        }

        let mut dp = vec![0; (max_num + 1) as usize];
        dp[1] = *counts.get(&1).unwrap_or(&0);

        for i in 2..=(max_num as usize) {
            dp[i] = dp[i - 1].max(dp[i - 2] + *counts.get(&(i as i32)).unwrap_or(&0));
        }

        dp[max_num as usize]
    }
}