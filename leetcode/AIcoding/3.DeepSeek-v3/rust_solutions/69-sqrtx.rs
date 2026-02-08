impl Solution {
    pub fn my_sqrt(x: i32) -> i32 {
        if x == 0 {
            return 0;
        }
        let mut left = 1;
        let mut right = x;
        let mut res = 0;
        while left <= right {
            let mid = left + (right - left) / 2;
            if mid <= x / mid {
                left = mid + 1;
                res = mid;
            } else {
                right = mid - 1;
            }
        }
        res
    }
}