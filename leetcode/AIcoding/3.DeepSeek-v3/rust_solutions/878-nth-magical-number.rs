impl Solution {
    pub fn nth_magical_number(n: i32, a: i32, b: i32) -> i32 {
        let modulo = 1_000_000_007;
        let n = n as i64;
        let a = a as i64;
        let b = b as i64;

        let lcm = a * b / Solution::gcd(a, b);
        let mut left = 0;
        let mut right = n * std::cmp::min(a, b);

        while left < right {
            let mid = left + (right - left) / 2;
            let count = mid / a + mid / b - mid / lcm;
            if count < n {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        (left % modulo) as i32
    }

    fn gcd(a: i64, b: i64) -> i64 {
        if b == 0 {
            a
        } else {
            Solution::gcd(b, a % b)
        }
    }
}