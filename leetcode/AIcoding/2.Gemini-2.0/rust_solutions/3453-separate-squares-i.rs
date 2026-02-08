impl Solution {
    pub fn separate_squares_i(n: i32) -> bool {
        if n < 0 {
            return false;
        }
        let mut a = 0;
        while a * a <= n {
            let b_squared = n - a * a;
            let b = (b_squared as f64).sqrt() as i32;
            if b * b == b_squared {
                return true;
            }
            a += 1;
        }
        false
    }
}