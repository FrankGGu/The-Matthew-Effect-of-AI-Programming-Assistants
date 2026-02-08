impl Solution {
    pub fn minimum_perimeter(needed_apples: i64) -> i64 {
        let mut left = 0;
        let mut right = 1_000_000;
        while left < right {
            let mid = left + (right - left) / 2;
            if 2 * mid * (mid + 1) * (2 * mid + 1) >= needed_apples {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        8 * left
    }
}