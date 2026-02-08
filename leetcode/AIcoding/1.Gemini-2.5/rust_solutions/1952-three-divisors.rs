impl Solution {
    pub fn has_three_divisors(n: i32) -> bool {
        if n < 4 {
            return false;
        }

        let root_n_f64 = (n as f64).sqrt();
        let root_n = root_n_f64 as i32;

        if root_n * root_n != n {
            return false;
        }

        let p = root_n;

        if p <= 1 {
            return false;
        }
        if p == 2 || p == 3 {
            return true;
        }
        if p % 2 == 0 || p % 3 == 0 {
            return false;
        }

        let mut i = 5;
        while i * i <= p {
            if p % i == 0 || p % (i + 2) == 0 {
                return false;
            }
            i += 6;
        }

        true
    }
}