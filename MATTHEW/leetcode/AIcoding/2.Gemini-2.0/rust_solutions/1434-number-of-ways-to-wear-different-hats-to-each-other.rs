impl Solution {
    pub fn number_of_ways(hats: Vec<Vec<i32>>) -> i32 {
        let n = hats.len();
        let mut hat_to_people: Vec<Vec<usize>> = vec![Vec::new(); 41];
        for i in 0..n {
            for &hat in &hats[i] {
                hat_to_people[hat as usize].push(i);
            }
        }

        let mod_val = 1_000_000_007;
        let mut dp: Vec<i32> = vec![0; 1 << n];
        dp[0] = 1;

        for hat in 1..=40 {
            let mut next_dp: Vec<i32> = vec![0; 1 << n];
            for mask in 0..(1 << n) {
                next_dp[mask] = (next_dp[mask] + dp[mask]) % mod_val;
                for &person in &hat_to_people[hat] {
                    if (mask & (1 << person)) == 0 {
                        next_dp[mask | (1 << person)] = (next_dp[mask | (1 << person)] + dp[mask]) % mod_val;
                    }
                }
            }
            dp = next_dp;
        }

        dp[(1 << n) - 1]
    }
}