impl Solution {
    pub fn my_sqrt(x: i32) -> i32 {
        if x < 2 {
            return x;
        }

        let mut low = 1;
        let mut high = x;
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;

            let mid_squared = mid as i64 * mid as i64;

            if mid_squared <= x as i64 {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }
}