impl Solution {
    pub fn find_integers(n: i32) -> i32 {
        let mut fib = vec![0; 32];
        fib[0] = 1;
        fib[1] = 2;
        for i in 2..32 {
            fib[i] = fib[i - 1] + fib[i - 2];
        }

        let mut ans = 0;
        let mut prev_bit = 0;
        for i in (0..32).rev() {
            if (n & (1 << i)) != 0 {
                ans += fib[i];
                if prev_bit == 1 {
                    return ans;
                }
                prev_bit = 1;
            } else {
                prev_bit = 0;
            }
        }

        ans + 1
    }
}