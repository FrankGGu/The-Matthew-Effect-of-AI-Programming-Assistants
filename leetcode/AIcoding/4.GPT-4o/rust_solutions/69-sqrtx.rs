impl Solution {
    pub fn my_sqrt(x: i32) -> i32 {
        if x < 2 {
            return x;
        }
        let mut left = 2;
        let mut right = x / 2;
        while left <= right {
            let mid = left + (right - left) / 2;
            let sq = mid * mid;
            if sq == x {
                return mid;
            } else if sq < x {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        right
    }
}