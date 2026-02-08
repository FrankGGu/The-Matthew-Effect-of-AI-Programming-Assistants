impl Solution {
    pub fn min_operations(n: i32) -> i32 {
        let mut n = n as u32;
        let mut ans = 0;
        while n > 0 {
            if n & 1 == 1 {
                if n & 2 == 0 || n == 3 {
                    n -= 1;
                } else {
                    n += 1;
                }
                ans += 1;
            } else {
                n >>= 1;
            }
        }
        ans
    }
}