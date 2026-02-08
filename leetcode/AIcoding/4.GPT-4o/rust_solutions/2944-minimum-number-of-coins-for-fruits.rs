use std::collections::HashMap;

pub fn min_coins(fruits: Vec<i32>, coins: i32) -> i32 {
    let mut dp = vec![i32::MAX; (coins + 1) as usize];
    dp[0] = 0;

    for &fruit in &fruits {
        for j in (fruit..=coins).rev() {
            if dp[(j - fruit) as usize] != i32::MAX {
                dp[j as usize] = dp[j as usize].min(dp[(j - fruit) as usize] + 1);
            }
        }
    }

    if dp[coins as usize] == i32::MAX { -1 } else { dp[coins as usize] }
}