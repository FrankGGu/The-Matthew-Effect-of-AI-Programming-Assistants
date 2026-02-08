impl Solution {
    pub fn is_reachable(x: i32, y: i32, a: i32, b: i32) -> bool {
        fn gcd(x: i32, y: i32) -> i32 {
            if y == 0 { x } else { gcd(y, x % y) }
        }
        gcd(a, b) == gcd(x.abs(), y.abs())
    }
}