impl Solution {
    pub fn get_number_of_ways(head_count: i32, coin_types: Vec<i32>) -> i32 {
        let mut dp = vec![0; (head_count + 1) as usize];
        dp[0] = 1;

        for &coin in &coin_types {
            for i in coin as usize..=head_count as usize {
                dp[i] += dp[i - coin as usize];
            }
        }

        dp[head_count as usize]
    }
}