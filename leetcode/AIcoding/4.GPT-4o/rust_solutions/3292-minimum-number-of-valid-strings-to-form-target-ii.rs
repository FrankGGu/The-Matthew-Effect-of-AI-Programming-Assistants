pub fn min_number_of_valid_strings(target: String, strings: Vec<String>) -> i32 {
    let mut dp = vec![i32::MAX; target.len() + 1];
    dp[0] = 0;

    for s in strings {
        let mut count = vec![0; 26];
        for c in s.chars() {
            count[(c as usize - 'a' as usize)] += 1;
        }

        for j in (0..=target.len()).rev() {
            let mut new_count = 0;
            for c in target.chars() {
                let idx = (c as usize - 'a' as usize);
                if j > 0 && count[idx] > 0 {
                    new_count += 1;
                }
            }
            dp[j] = dp[j].min(dp[j - new_count] + 1);
        }
    }

    if dp[target.len()] == i32::MAX { -1 } else { dp[target.len()] }
}