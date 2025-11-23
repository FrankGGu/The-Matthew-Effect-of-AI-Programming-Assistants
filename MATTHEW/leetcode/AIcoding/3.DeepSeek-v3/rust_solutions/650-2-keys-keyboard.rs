impl Solution {
    pub fn min_steps(n: i32) -> i32 {
        if n == 1 {
            return 0;
        }
        let mut res = 0;
        let mut d = 2;
        let mut n = n;
        while n > 1 {
            while n % d == 0 {
                res += d;
                n /= d;
            }
            d += 1;
        }
        res
    }
}