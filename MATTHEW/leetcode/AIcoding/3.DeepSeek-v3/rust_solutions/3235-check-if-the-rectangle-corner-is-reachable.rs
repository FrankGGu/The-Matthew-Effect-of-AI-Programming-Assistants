impl Solution {
    pub fn is_reachable(target_x: i32, target_y: i32) -> bool {
        let mut x = target_x;
        let mut y = target_y;
        while x % 2 == 0 { x /= 2; }
        while y % 2 == 0 { y /= 2; }
        Self::gcd(x, y) == 1
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 { a } else { Self::gcd(b, a % b) }
    }
}