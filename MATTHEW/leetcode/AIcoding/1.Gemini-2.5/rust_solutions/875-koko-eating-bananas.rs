impl Solution {
    pub fn min_eating_speed(piles: Vec<i32>, h: i32) -> i32 {
        let mut low = 1;
        let mut high = 0;
        for &pile in piles.iter() {
            if pile > high {
                high = pile;
            }
        }

        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            let mut hours_needed: i64 = 0;
            for &pile in piles.iter() {
                hours_needed += (pile as i64 + mid as i64 - 1) / (mid as i64);
            }

            if hours_needed <= h as i64 {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }
}