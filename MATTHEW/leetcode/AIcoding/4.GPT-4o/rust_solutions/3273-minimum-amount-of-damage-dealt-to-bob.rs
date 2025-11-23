pub fn minimum_damage(bob: i32, alice: i32) -> i32 {
    let mut dp = vec![vec![0; bob as usize + 1]; alice as usize + 1];

    for a in 1..=alice {
        for b in 1..=bob {
            let attack = a / 2;
            let damage = if b <= attack { b } else { attack };
            dp[a as usize][b as usize] = damage + dp[a - 1][b - damage as usize];
        }
    }

    dp[alice as usize][bob as usize]
}