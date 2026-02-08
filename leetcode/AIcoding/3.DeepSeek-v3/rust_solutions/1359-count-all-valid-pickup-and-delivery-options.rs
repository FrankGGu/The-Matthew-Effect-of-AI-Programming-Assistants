impl Solution {
    pub fn count_orders(n: i32) -> i32 {
        let mut res: i64 = 1;
        let modulo: i64 = 1_000_000_007;
        for i in 1..=n as i64 {
            res = res * i * (2 * i - 1) % modulo;
        }
        res as i32
    }
}