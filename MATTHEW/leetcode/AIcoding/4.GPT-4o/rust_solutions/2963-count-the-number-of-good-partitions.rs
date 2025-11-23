pub fn count_good_partitions(s: String, k: i32) -> i32 {
    let n = s.len();
    let mut dp = vec![0; n + 1];
    let mut count = vec![0; 26];
    let mut good_count = 0;

    dp[0] = 1;

    for i in 1..=n {
        let mut unique_characters = 0;
        count.fill(0);

        for j in (1..=i).rev() {
            let idx = (s.chars().nth(j - 1).unwrap() as usize) - ('a' as usize);
            if count[idx] == 0 {
                unique_characters += 1;
            }
            count[idx] += 1;

            if unique_characters > k {
                break;
            }
            dp[i] = (dp[i] + dp[j - 1]) % 1_000_000_007;
        }
    }

    dp[n]
}