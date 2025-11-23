struct Solution {}

impl Solution {
    pub fn tribonacci(n: i32) -> i32 {
        if n == 0 {
            return 0;
        } else if n == 1 || n == 2 {
            return 1;
        }

        let mut a = 0;
        let mut b = 1;
        let mut c = 1;

        for _ in 3..=n {
            let d = a + b + c;
            a = b;
            b = c;
            c = d;
        }

        c
    }
}