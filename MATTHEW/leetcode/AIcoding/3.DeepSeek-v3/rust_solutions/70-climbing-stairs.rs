impl Solution {
    pub fn climb_stairs(n: i32) -> i32 {
        if n <= 2 {
            return n;
        }
        let mut a = 1;
        let mut b = 2;
        for _ in 3..=n {
            let c = a + b;
            a = b;
            b = c;
        }
        b
    }
}