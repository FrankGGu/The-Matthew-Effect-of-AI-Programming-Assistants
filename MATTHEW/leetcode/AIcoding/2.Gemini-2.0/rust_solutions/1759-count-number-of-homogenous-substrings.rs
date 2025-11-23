impl Solution {
    pub fn count_homogenous(s: String) -> i32 {
        let s_bytes = s.as_bytes();
        let mut count: i64 = 0;
        let mut current_len: i64 = 0;

        for i in 0..s_bytes.len() {
            if i > 0 && s_bytes[i] == s_bytes[i - 1] {
                current_len += 1;
            } else {
                current_len = 1;
            }
            count = (count + current_len) % 1000000007;
        }

        count as i32
    }
}