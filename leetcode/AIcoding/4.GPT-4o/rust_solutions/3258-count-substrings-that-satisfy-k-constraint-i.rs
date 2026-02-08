impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s.len();
        let mut result = 0;

        for i in 0..n {
            let mut count = 0;
            for j in i..n {
                if s_bytes[j] == b'a' {
                    count += 1;
                }
                if count >= k {
                    result += 1;
                }
            }
        }

        result
    }
}