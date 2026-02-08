impl Solution {
    pub fn number_of_unique_good_subsequences(binary: String) -> i32 {
        let s = binary.as_bytes();
        let n = s.len();
        let mut dp0 = 0;
        let mut dp1 = 0;
        let mut has_zero = 0;
        let mod_num = 1_000_000_007;

        for i in (0..n).rev() {
            if s[i] == b'0' {
                has_zero = 1;
                dp0 = (dp0 + dp1 + 1) % mod_num;
            } else {
                dp1 = (dp0 + dp1 + 1) % mod_num;
            }
        }

        (dp1 + has_zero) % mod_num
    }
}