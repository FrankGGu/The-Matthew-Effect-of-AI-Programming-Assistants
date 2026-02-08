impl Solution {
    pub fn longest_special_substring(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut max_len = -1;

        for len in (1..=(n / 3)).rev() {
            for i in 0..=(n - len) {
                let sub = &s_bytes[i..(i + len)];
                let mut count = 0;
                for j in 0..=(n - len) {
                    if &s_bytes[j..(j + len)] == sub {
                        count += 1;
                    }
                }
                if count >= 3 {
                    max_len = len as i32;
                    return max_len;
                }
            }
        }

        max_len
    }
}