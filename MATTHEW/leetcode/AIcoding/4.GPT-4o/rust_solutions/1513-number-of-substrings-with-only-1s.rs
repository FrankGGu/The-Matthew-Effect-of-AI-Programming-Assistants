impl Solution {
    pub fn num_sub(s: String) -> i32 {
        let mut count = 0;
        let mut total = 0;
        const MOD: i32 = 1_000_000_007;

        for c in s.chars() {
            if c == '1' {
                count += 1;
                total = (total + count) % MOD;
            } else {
                count = 0;
            }
        }

        total
    }
}