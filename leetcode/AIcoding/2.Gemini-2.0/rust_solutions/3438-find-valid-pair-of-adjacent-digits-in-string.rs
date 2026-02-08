impl Solution {
    pub fn valid_pair(s: String) -> bool {
        let bytes = s.as_bytes();
        for i in 0..bytes.len() - 1 {
            let a = (bytes[i] - b'0') as i32;
            let b = (bytes[i + 1] - b'0') as i32;
            if (a + b) % 2 != 0 && a != b {
                return true;
            }
        }
        false
    }
}