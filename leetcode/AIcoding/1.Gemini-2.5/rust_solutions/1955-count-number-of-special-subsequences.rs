impl Solution {
    pub fn count_special_subsequences(s: String) -> i32 {
        let modulo: i64 = 1_000_000_007;
        let mut dp0: i64 = 0;
        let mut dp1: i64 = 0;
        let mut dp2: i64 = 0;

        for c in s.chars() {
            match c {
                '0' => {
                    dp0 = (2 * dp0 + 1) % modulo;
                }
                '1' => {
                    dp1 = (2 * dp1 + dp0) % modulo;
                }
                '2' => {
                    dp2 = (2 * dp2 + dp1) % modulo;
                }
                _ => {}
            }
        }

        dp2 as i32
    }
}