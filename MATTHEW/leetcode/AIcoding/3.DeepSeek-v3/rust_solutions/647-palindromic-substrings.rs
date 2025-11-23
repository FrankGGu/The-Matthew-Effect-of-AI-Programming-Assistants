impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let mut count = 0;

        for i in 0..n {
            let (mut l, mut r) = (i, i);
            while l < n && r < n && s_chars[l] == s_chars[r] {
                count += 1;
                if l == 0 {
                    break;
                }
                l -= 1;
                r += 1;
            }

            let (mut l, mut r) = (i, i + 1);
            while l < n && r < n && s_chars[l] == s_chars[r] {
                count += 1;
                if l == 0 {
                    break;
                }
                l -= 1;
                r += 1;
            }
        }

        count
    }
}