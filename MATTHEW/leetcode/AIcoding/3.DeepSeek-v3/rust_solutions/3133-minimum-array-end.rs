impl Solution {
    pub fn min_end(n: i32, x: i32) -> i64 {
        let mut x = x as i64;
        let mut n = n as i64 - 1;
        let mut res = x;
        let mut mask = 1;
        while n > 0 {
            if (x & mask) == 0 {
                res |= (n & 1) * mask;
                n >>= 1;
            }
            mask <<= 1;
        }
        res
    }
}