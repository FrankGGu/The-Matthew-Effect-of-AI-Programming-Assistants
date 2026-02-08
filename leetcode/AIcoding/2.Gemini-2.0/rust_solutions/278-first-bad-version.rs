impl Solution {
    pub fn first_bad_version(&self, n: i32) -> i32 {
        let mut low: i64 = 1;
        let mut high: i64 = n as i64;

        while low <= high {
            let mid: i64 = low + (high - low) / 2;
            if self.isBadVersion(mid as i32) {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        low as i32
    }
}