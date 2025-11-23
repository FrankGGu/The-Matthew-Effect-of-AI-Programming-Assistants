impl Solution {
    pub fn is_perfect_square(num: i32) -> bool {
        if num == 1 {
            return true;
        }

        let mut low: i32 = 1;
        let mut high: i32 = num;

        while low <= high {
            let mid = low + (high - low) / 2;

            // Use i64 for mid_squared to prevent overflow, as mid * mid can exceed i32::MAX
            let mid_long = mid as i64;
            let mid_squared = mid_long * mid_long;

            if mid_squared == num as i64 {
                return true;
            } else if mid_squared < num as i64 {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        false
    }
}