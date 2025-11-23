use std::collections::HashMap;

pub fn num_ways(words: Vec<String>, target: String) -> i32 {
    let mod_val = 1_000_000_007;
    let m = words.len();
    let n = words[0].len();
    let k = target.len();

    let mut count = vec![vec![0; 26]; n];
    for word in words {
        for (j, c) in word.chars().enumerate() {
            count[j][(c as u8 - b'a') as usize] += 1;
        }
    }

    let mut dp = vec![0; k + 1];
    dp[0] = 1;

    for j in 0..n {
        for i in (0..k).rev() {
            dp[i + 1] = (dp[i + 1] + dp[i] * count[j][(target.as_bytes()[i] - b'a') as usize]) % mod_val;
        }
    }

    dp[k]
}