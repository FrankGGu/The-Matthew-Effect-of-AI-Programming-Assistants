impl Solution {
    pub fn is_three(n: i32) -> bool {
        if n < 4 {
            return false;
        }
        let sqrt_n = (n as f64).sqrt() as i32;
        if sqrt_n * sqrt_n != n {
            return false;
        }
        for i in 2..sqrt_n {
            if sqrt_n % i == 0 {
                return false;
            }
        }
        true
    }
}