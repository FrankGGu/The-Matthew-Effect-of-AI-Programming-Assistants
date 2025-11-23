impl Solution {
    pub fn min_non_zero_product(p: i32) -> i32 {
        let n = (1i64 << p) - 1;
        let mut ans = 1i64;
        let mut base = n % 1000000007;
        let mut exp = n / 2;

        while exp > 0 {
            if exp % 2 == 1 {
                ans = (ans * base) % 1000000007;
            }
            base = (base * base) % 1000000007;
            exp /= 2;
        }

        ((ans * (n % 1000000007)) % 1000000007) as i32
    }
}