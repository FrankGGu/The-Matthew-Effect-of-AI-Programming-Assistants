impl Solution {
    pub fn min_operations(n: i32) -> i32 {
        let mut res = 0;
        let mut n = n;
        while n > 0 {
            if (n & 3) == 3 {
                n += 1;
                res += 1;
            } else {
                res += n & 1;
                n >>= 1;
            }
        }
        res
    }
}