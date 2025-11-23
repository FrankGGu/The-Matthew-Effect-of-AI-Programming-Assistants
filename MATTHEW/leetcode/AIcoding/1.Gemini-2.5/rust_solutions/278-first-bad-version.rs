impl Solution {
    pub fn first_bad_version(n: i32) -> i32 {
        let mut low = 1;
        let mut high = n;
        let mut first_bad = n;

        while low <= high {
            let mid = low + (high - low) / 2;
            if is_bad_version(mid) {
                first_bad = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        first_bad
    }
}