impl Solution {
    pub fn nth_ugly_number(n: i32, a: i32, b: i32, c: i32) -> i32 {
        let a = a as i64;
        let b = b as i64;
        let c = c as i64;
        let n = n as i64;

        fn gcd(a: i64, b: i64) -> i64 {
            if b == 0 {
                a
            } else {
                gcd(b, a % b)
            }
        }

        fn lcm(a: i64, b: i64) -> i64 {
            a * b / gcd(a, b)
        }

        let ab = lcm(a, b);
        let ac = lcm(a, c);
        let bc = lcm(b, c);
        let abc = lcm(a, bc);

        let mut low = 1;
        let mut high = 2 * 10i64.pow(9);

        while low < high {
            let mid = low + (high - low) / 2;
            let count = mid / a + mid / b + mid / c - mid / ab - mid / ac - mid / bc + mid / abc;
            if count < n {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        low as i32
    }
}