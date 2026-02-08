impl Solution {
    pub fn nth_ugly_number(n: i32, a: i32, b: i32, c: i32) -> i32 {
        let (a, b, c) = (a as i64, b as i64, c as i64);
        let n = n as i64;
        let mut left = 1;
        let mut right = 2 * 10i64.pow(9);

        let gcd = |x: i64, y: i64| -> i64 {
            let mut x = x;
            let mut y = y;
            while y != 0 {
                let temp = y;
                y = x % y;
                x = temp;
            }
            x
        };

        let lcm = |x: i64, y: i64| -> i64 {
            x * y / gcd(x, y)
        };

        while left < right {
            let mid = left + (right - left) / 2;
            let count = mid / a + mid / b + mid / c 
                      - mid / lcm(a, b) - mid / lcm(a, c) - mid / lcm(b, c) 
                      + mid / lcm(a, lcm(b, c));
            if count < n {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        left as i32
    }
}