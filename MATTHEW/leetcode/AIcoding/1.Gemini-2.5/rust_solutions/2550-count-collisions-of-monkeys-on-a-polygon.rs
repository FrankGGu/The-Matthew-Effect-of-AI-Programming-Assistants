struct Solution;

impl Solution {
    pub fn count_collisions(n: i32) -> i32 {
        let n_long = n as i64;
        let modulus: i64 = 1_000_000_007;

        let mut res: i64 = 1;
        let mut base: i64 = 2;
        let mut exp: i64 = n_long;

        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % modulus;
            }
            base = (base * base) % modulus;
            exp /= 2;
        }

        let result = (res - 2 + modulus) % modulus;
        result as i32
    }
}