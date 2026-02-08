impl Solution {
    pub fn is_perfect_square(num: i32) -> bool {
        if num < 1 {
            return false;
        }
        let mut left = 1;
        let mut right = num as i64;
        while left <= right {
            let mid = left + (right - left) / 2;
            let square = mid * mid;
            if square == num as i64 {
                return true;
            } else if square < num as i64 {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        false
    }
}