impl Solution {
    pub fn concatenated_binary(n: i32) -> i32 {
        let mut res: i64 = 0;
        let modulo: i64 = 1_000_000_007;
        for i in 1..=n as i64 {
            let bits = (i as f64).log2().floor() as i64 + 1;
            res = ((res << bits) | i) % modulo;
        }
        res as i32
    }
}