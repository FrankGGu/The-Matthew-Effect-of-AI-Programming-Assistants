impl Solution {
    pub fn minimize_concatenated_length(words: Vec<String>) -> i32 {
        let n = words.len();
        if n == 0 {
            return 0;
        }
        let first_word = words[0].as_bytes();
        let first_char = first_word[0] as usize - 'a' as usize;
        let last_char = first_word[first_word.len() - 1] as usize - 'a' as usize;
        let mut dp = vec![vec![vec![std::i32::MAX; 26]; 26]; n];
        dp[0][first_char][last_char] = first_word.len() as i32;

        for i in 1..n {
            let current = words[i].as_bytes();
            let len = current.len() as i32;
            let first = current[0] as usize - 'a' as usize;
            let last = current[current.len() - 1] as usize - 'a' as usize;

            for a in 0..26 {
                for b in 0..26 {
                    if dp[i-1][a][b] == std::i32::MAX {
                        continue;
                    }
                    // Case 1: append current word to the end
                    let cost1 = if b == first { len - 1 } else { len };
                    let new_len1 = dp[i-1][a][b] + cost1;
                    if new_len1 < dp[i][a][last] {
                        dp[i][a][last] = new_len1;
                    }

                    // Case 2: prepend current word to the beginning
                    let cost2 = if a == last { len - 1 } else { len };
                    let new_len2 = dp[i-1][a][b] + cost2;
                    if new_len2 < dp[i][first][b] {
                        dp[i][first][b] = new_len2;
                    }
                }
            }
        }

        let mut min_len = std::i32::MAX;
        for a in 0..26 {
            for b in 0..26 {
                if dp[n-1][a][b] < min_len {
                    min_len = dp[n-1][a][b];
                }
            }
        }
        min_len
    }
}