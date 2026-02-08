impl Solution {
    pub fn longest_duplicate_substring(s: String) -> String {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let a: i64 = 26;
        let modulus: i64 = 2_i64.pow(32);

        let mut left: i32 = 1;
        let mut right: i32 = (n - 1) as i32;
        let mut start: i32 = 0;
        let mut max_len: i32 = 0;

        while left <= right {
            let len = (left + right) / 2;
            let mut h: i64 = 0;
            let mut seen: std::collections::HashSet<i64> = std::collections::HashSet::new();

            for i in 0..len as usize {
                h = (h * a + (s_bytes[i] - b'a') as i64) % modulus;
            }

            seen.insert(h);
            let mut found = false;

            let mut a_l = 1;
            for _ in 1..len {
                a_l = (a_l * a) % modulus;
            }

            for i in 1..n - len as usize + 1 {
                h = (h * a - (s_bytes[i - 1] - b'a') as i64 * a_l % modulus + modulus) % modulus;
                h = (h + (s_bytes[i + len as usize - 1] - b'a') as i64) % modulus;
                if seen.contains(&h) {
                    found = true;
                    start = i as i32;
                    max_len = len;
                    break;
                }
                seen.insert(h);
            }

            if found {
                left = len + 1;
            } else {
                right = len - 1;
            }
        }

        if max_len == 0 {
            "".to_string()
        } else {
            s[start as usize..(start + max_len) as usize].to_string()
        }
    }
}