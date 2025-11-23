impl Solution {
    pub fn smallest_substring(s: String) -> String {
        let s = s.chars().collect::<Vec<_>>();
        let n = s.len();
        let mut min_len = n;
        let mut start = 0;

        for i in 0..n {
            let mut j = i;
            while j < n && s[j] == s[i] {
                j += 1;
            }
            if j - i < min_len {
                min_len = j - i;
                start = i;
            }
        }

        s[start..start + min_len].iter().collect()
    }
}