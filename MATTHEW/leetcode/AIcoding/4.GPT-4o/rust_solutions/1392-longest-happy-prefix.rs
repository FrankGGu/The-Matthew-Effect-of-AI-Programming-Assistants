impl Solution {
    pub fn longest_happy_prefix(s: String) -> String {
        let n = s.len();
        let mut lps = vec![0; n];
        let mut j = 0;

        for i in 1..n {
            while j > 0 && s.chars().nth(i) != s.chars().nth(j) {
                j = lps[j - 1];
            }
            if s.chars().nth(i) == s.chars().nth(j) {
                j += 1;
                lps[i] = j;
            }
        }

        s[0..lps[n - 1]].to_string()
    }
}