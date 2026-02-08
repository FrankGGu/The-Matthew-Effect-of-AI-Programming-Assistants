impl Solution {
    pub fn count_substrings(s: String, t: String) -> i32 {
        let (s, t) = (s.as_bytes(), t.as_bytes());
        let (m, n) = (s.len(), t.len());
        let mut count = 0;

        for i in 0..m {
            let mut freq_s = [0; 26];
            let mut freq_t = [0; 26];
            for j in i..m {
                freq_s[(s[j] - b'a') as usize] += 1;
                if j - i < n {
                    freq_t[(t[j - i] - b'a') as usize] += 1;
                }
                if j - i + 1 >= n {
                    if freq_s.iter().zip(&freq_t).all(|(s_count, t_count)| s_count >= t_count) {
                        count += 1;
                    }
                    freq_t[(t[j - i - n + 1] - b'a') as usize] -= 1;
                }
            }
        }
        count
    }
}