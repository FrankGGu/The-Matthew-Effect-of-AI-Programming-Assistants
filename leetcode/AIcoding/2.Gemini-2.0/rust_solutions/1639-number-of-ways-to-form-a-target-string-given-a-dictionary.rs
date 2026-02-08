impl Solution {
    pub fn num_ways(words: Vec<String>, target: String) -> i32 {
        let m = target.len();
        let n = words[0].len();
        let modulo = 1_000_000_007;

        let mut counts: Vec<[i64; 26]> = vec![[0; 26]; n];
        for word in &words {
            for (i, c) in word.chars().enumerate() {
                counts[i][(c as u8 - b'a') as usize] += 1;
            }
        }

        let mut dp: Vec<i64> = vec![0; m + 1];
        dp[0] = 1;

        for i in 0..n {
            for j in (0..m).rev() {
                let char_index = (target.chars().nth(j).unwrap() as u8 - b'a') as usize;
                dp[j + 1] = (dp[j + 1] + (dp[j] * counts[i][char_index]) % modulo) % modulo;
            }
        }

        dp[m] as i32
    }
}