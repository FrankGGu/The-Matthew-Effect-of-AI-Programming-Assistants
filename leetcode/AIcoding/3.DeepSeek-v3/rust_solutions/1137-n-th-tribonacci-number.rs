impl Solution {
    pub fn tribonacci(n: i32) -> i32 {
        match n {
            0 => 0,
            1 | 2 => 1,
            _ => {
                let mut a = 0;
                let mut b = 1;
                let mut c = 1;
                for _ in 3..=n {
                    let next = a + b + c;
                    a = b;
                    b = c;
                    c = next;
                }
                c
            }
        }
    }
}