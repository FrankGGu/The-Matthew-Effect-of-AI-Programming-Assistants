impl Solution {
    pub fn super_pow(a: i32, b: Vec<i32>) -> i32 {
        const MOD: i32 = 1337;
        if b.is_empty() {
            return 1;
        }
        let a_mod = a % MOD;
        let last = b[b.len() - 1];
        let mut new_b = b.clone();
        new_b.pop();

        let part1 = Self::pow_mod(a_mod, last);
        let part2 = Self::pow_mod(Self::super_pow(a, new_b), 10);

        (part1 * part2) % MOD
    }

    fn pow_mod(mut x: i32, mut n: i32) -> i32 {
        const MOD: i32 = 1337;
        let mut res = 1;
        x %= MOD;
        while n > 0 {
            if n % 2 == 1 {
                res = (res * x) % MOD;
            }
            x = (x * x) % MOD;
            n /= 2;
        }
        res
    }
}