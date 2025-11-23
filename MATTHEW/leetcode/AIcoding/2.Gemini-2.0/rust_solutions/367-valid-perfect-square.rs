impl Solution {
    pub fn is_perfect_square(num: i32) -> bool {
        let mut left: i64 = 1;
        let mut right: i64 = num as i64;

        while left <= right {
            let mid: i64 = left + (right - left) / 2;
            let square: i64 = mid * mid;

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