impl Solution {
    pub fn nth_ugly_number(n: i32, a: i32, b: i32, c: i32) -> i32 {
        fn gcd(x: i32, y: i32) -> i32 {
            if y == 0 { x } else { gcd(y, x % y) }
        }

        fn lcm(x: i32, y: i32) -> i32 {
            x / gcd(x, y) * y
        }

        let ab = lcm(a, b);
        let ac = lcm(a, c);
        let bc = lcm(b, c);
        let abc = lcm(ab, c);

        let count = |x| {
            x / a + x / b + x / c - x / ab - x / ac - x / bc + x / abc
        };

        let (mut left, mut right) = (1, 2_000_000_000);
        while left < right {
            let mid = left + (right - left) / 2;
            if count(mid) < n {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        left
    }
}