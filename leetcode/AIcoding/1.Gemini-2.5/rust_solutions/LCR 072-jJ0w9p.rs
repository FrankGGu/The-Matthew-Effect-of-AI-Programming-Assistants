impl Solution {
    pub fn my_sqrt(x: i32) -> i32 {
        if x == 0 {
            return 0;
        }

        let mut left: i32 = 1;
        let mut right: i32 = x;
        let mut ans: i32 = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mid_squared = mid as i64 * mid as i64;

            if mid_squared == x as i64 {
                return mid;
            } else if mid_squared < x as i64 {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        ans
    }
}