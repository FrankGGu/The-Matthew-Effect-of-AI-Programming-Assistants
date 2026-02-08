impl Solution {
    pub fn number_of_substrings(s: String) -> i64 {
        let s = s.as_bytes();
        let mut res = 0;
        let mut last_zero = -1;

        for (i, &ch) in s.iter().enumerate() {
            if ch == b'0' {
                last_zero = i as i64;
            } else {
                res += (i as i64 - last_zero);
            }
        }
        res
    }
}