impl Solution {
    pub fn longest_substring_of_one_repeating_character(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut ans = 0;

        for i in 0..n {
            for j in i..n {
                let mut freq = [0; 26];
                let mut max_freq = 0;
                for l in i..=j {
                    let idx = (s[l] - b'a') as usize;
                    freq[idx] += 1;
                    max_freq = max_freq.max(freq[idx]);
                }

                let len = (j - i + 1) as i32;
                if len - max_freq <= k {
                    ans = ans.max(len);
                }
            }
        }

        ans
    }
}