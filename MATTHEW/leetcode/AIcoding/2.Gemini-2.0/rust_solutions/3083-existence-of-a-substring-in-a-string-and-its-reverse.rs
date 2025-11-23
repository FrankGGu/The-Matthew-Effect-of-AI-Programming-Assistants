impl Solution {
    pub fn exist_substring(s: String, sub: String) -> bool {
        let s_bytes = s.as_bytes();
        let sub_bytes = sub.as_bytes();
        let sub_len = sub_bytes.len();
        let s_len = s_bytes.len();

        if sub_len > s_len {
            return false;
        }

        for i in 0..=(s_len - sub_len) {
            if s_bytes[i..i + sub_len] == *sub_bytes {
                return true;
            }

            let mut reversed_sub = sub_bytes.to_vec();
            reversed_sub.reverse();

            if s_bytes[i..i + sub_len] == *reversed_sub {
                return true;
            }
        }

        false
    }
}