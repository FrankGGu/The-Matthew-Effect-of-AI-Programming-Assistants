impl Solution {
    pub fn climb_stairs(n: i32) -> i32 {
        if n <= 2 {
            return n;
        }
        let (mut a, mut b) = (1, 2);
        for _ in 3..=n {
            let temp = b;
            b += a;
            a = temp;
        }
        b
    }
}