impl Solution {
    pub fn super_pow(a: i32, b: Vec<i32>) -> i32 {
        const MOD: i32 = 1337;
        let mut result = 1;
        let mut base = a % MOD;

        for &digit in b.iter().rev() {
            result = (result * Self::pow(base, digit)) % MOD;
            base = Self::pow(base, 10);
        }

        result
    }

    fn pow(x: i32, n: i32) -> i32 {
        if n == 0 { return 1; }
        let mut res = 1;
        let mut base = x;
        let mut exp = n;

        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % 1337;
            }
            base = (base * base) % 1337;
            exp /= 2;
        }

        res
    }
}