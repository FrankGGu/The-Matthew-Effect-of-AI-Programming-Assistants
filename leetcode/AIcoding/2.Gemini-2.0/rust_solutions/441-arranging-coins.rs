impl Solution {
    pub fn arrange_coins(n: i32) -> i32 {
        let n_long = n as i64;
        let mut left: i64 = 0;
        let mut right: i64 = n_long;

        while left <= right {
            let mid: i64 = left + (right - left) / 2;
            let coins_needed: i64 = mid * (mid + 1) / 2;

            if coins_needed == n_long {
                return mid as i32;
            } else if coins_needed < n_long {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        right as i32
    }
}