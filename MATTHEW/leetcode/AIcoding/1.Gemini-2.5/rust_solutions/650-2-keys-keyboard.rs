impl Solution {
    pub fn min_steps(n: i32) -> i32 {
        if n == 1 {
            return 0;
        }

        let mut ans = 0;
        let mut num = n;
        let mut d = 2;

        while num > 1 {
            while num % d == 0 {
                ans += d;
                num /= d;
            }
            d += 1;
        }
        ans
    }
}