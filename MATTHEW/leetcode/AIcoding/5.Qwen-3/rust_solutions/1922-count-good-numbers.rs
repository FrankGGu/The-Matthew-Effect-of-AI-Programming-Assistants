struct Solution;

impl Solution {
    pub fn count_good_numbers(n: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let mut result = 1;
        let even_count = 5;
        let odd_count = 4;
        let n = n as i64;

        for i in 0..n {
            if i % 2 == 0 {
                result = (result * even_count as i64) % MOD;
            } else {
                result = (result * odd_count as i64) % MOD;
            }
        }

        result as i32
    }
}