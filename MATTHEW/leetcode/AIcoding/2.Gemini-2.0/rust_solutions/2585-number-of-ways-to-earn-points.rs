impl Solution {
    pub fn number_of_ways(target: i32, types: Vec<Vec<i32>>) -> i32 {
        let target = target as usize;
        let mut dp = vec![0; target + 1];
        dp[0] = 1;

        for type_ in types {
            let count = type_[0] as usize;
            let value = type_[1] as usize;

            for i in 1..=count {
                for j in (value..=target).rev() {
                    if j >= value {
                        dp[j] = (dp[j] + dp[j - value]) % 1000000007;
                    }
                }
            }
        }

        dp[target]
    }
}