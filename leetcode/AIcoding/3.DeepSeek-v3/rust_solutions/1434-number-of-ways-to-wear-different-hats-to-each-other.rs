impl Solution {
    pub fn number_ways(hats: Vec<Vec<i32>>) -> i32 {
        let n = hats.len();
        let max_hat = hats.iter().flatten().max().unwrap_or(&0);
        let max_hat = *max_hat as usize;
        let mut hat_to_people = vec![vec![]; max_hat + 1];
        for person in 0..n {
            for &hat in &hats[person] {
                hat_to_people[hat as usize].push(person);
            }
        }

        let mod_num = 1_000_000_007;
        let mut dp = vec![0; 1 << n];
        dp[0] = 1;

        for hat in 1..=max_hat {
            for mask in (0..(1 << n)).rev() {
                for &person in &hat_to_people[hat] {
                    let new_mask = mask | (1 << person);
                    if new_mask != mask {
                        dp[new_mask] = (dp[new_mask] + dp[mask]) % mod_num;
                    }
                }
            }
        }

        dp[(1 << n) - 1]
    }
}