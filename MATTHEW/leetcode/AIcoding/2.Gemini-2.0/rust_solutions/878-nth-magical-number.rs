impl Solution {
    pub fn nth_magical_number(n: i32, a: i32, b: i32) -> i32 {
        let a = a as i64;
        let b = b as i64;
        let n = n as i64;
        let lcm = a * b / Self::gcd(a, b);
        let mut low = 0;
        let mut high = 10_i64.pow(15);
        let modulo = 1_000_000_007;

        while low < high {
            let mid = low + (high - low) / 2;
            let count = mid / a + mid / b - mid / lcm;
            if count < n {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        (low % modulo) as i32
    }

    fn gcd(a: i64, b: i64) -> i64 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}