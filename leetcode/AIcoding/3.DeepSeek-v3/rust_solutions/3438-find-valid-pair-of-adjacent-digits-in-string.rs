impl Solution {
    pub fn is_valid(s: String) -> bool {
        let s = s.as_bytes();
        for i in 0..s.len() - 1 {
            let a = s[i] - b'0';
            let b = s[i + 1] - b'0';
            if (a + b) % 2 != 0 {
                return false;
            }
        }
        true
    }
}