use std::collections::HashMap;

pub fn number_ways(hats: Vec<Vec<i32>>) -> i32 {
    let mod_val = 1_000_000_007;
    let n = hats.len();
    let mut hat_to_people = vec![Vec::new(); 41];

    for (person, hat_list) in hats.iter().enumerate() {
        for &hat in hat_list {
            hat_to_people[hat as usize].push(person);
        }
    }

    let mut dp = vec![0; 1 << n];
    dp[0] = 1;

    for hat in 1..=40 {
        let mut new_dp = dp.clone();
        for mask in 0..(1 << n) {
            if dp[mask] > 0 {
                for &person in &hat_to_people[hat as usize] {
                    let new_mask = mask | (1 << person);
                    new_dp[new_mask] = (new_dp[new_mask] + dp[mask]) % mod_val;
                }
            }
        }
        dp = new_dp;
    }

    dp.iter().fold(0, |acc, &x| (acc + x) % mod_val)
}