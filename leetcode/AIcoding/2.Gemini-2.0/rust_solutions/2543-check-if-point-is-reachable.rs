impl Solution {
    pub fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Solution::gcd(b, a % b)
        }
    }

    pub fn is_reachable(target_x: i32, target_y: i32) -> bool {
        Solution::gcd(target_x, target_y) & (Solution::gcd(target_x, target_y) - 1) == 0
    }
}