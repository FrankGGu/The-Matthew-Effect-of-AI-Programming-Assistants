impl Solution {
    pub fn num_of_ways(n: i32) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let n = n as i64;
        let (mut a, mut b) = (6, 6);
        for _ in 2..=n {
            let c = (2 * b + 3 * a) % MOD;
            a = b;
            b = c;
        }
        (b % MOD) as i32
    }
}