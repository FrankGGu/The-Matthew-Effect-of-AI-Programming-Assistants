impl Solution {
    pub fn is_reachable(height: i32, width: i32, target_row: i32, target_col: i32) -> bool {
        gcd(height - 1, width - 1) == gcd(target_row - 1, target_col - 1) && gcd(height - 1, width - 1) == gcd(gcd(target_row - 1, target_col - 1), gcd(height - 1, width - 1))
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}