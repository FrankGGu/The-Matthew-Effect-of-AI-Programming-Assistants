impl Solution {
    pub fn max_nice_divisors(n: i32) -> i32 {
        if n <= 3 {
            return n;
        }
        let mod_val = 1_000_000_007;
        let mut result = 1;
        let mut x = n;

        while x > 4 {
            result = (result * 3) % mod_val;
            x -= 3;
        }
        result = (result * x) % mod_val;
        result
    }
}