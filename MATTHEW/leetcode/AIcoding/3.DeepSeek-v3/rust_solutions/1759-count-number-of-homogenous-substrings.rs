impl Solution {
    pub fn count_homogenous(s: String) -> i32 {
        let s = s.as_bytes();
        let mut res = 0;
        let mut current_len = 1;
        let mod_val = 1_000_000_007;

        for i in 1..s.len() {
            if s[i] == s[i - 1] {
                current_len += 1;
            } else {
                res = (res + (current_len * (current_len + 1) / 2) % mod_val) % mod_val;
                current_len = 1;
            }
        }
        res = (res + (current_len * (current_len + 1) / 2) % mod_val) % mod_val;
        res
    }
}