struct Solution {}

impl Solution {
    pub fn fib(n: i32) -> i32 {
        if n < 0 {
            return 0;
        }
        let mut a = 0;
        let mut b = 1;
        for _ in 0..n {
            let c = a + b;
            a = b;
            b = c;
        }
        a
    }
}