impl Solution {
    pub fn my_sqrt(x: i32) -> i32 {
        if x == 0 {
            return 0;
        }

        let mut low = 1;
        let mut high = x;
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if mid as i64 * mid as i64 <= x as i64 {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        ans
    }
}