impl Solution {
    pub fn min_eating_speed(piles: Vec<i32>, h: i32) -> i32 {
        let mut low: i64 = 1;
        let mut high: i64 = *piles.iter().max().unwrap() as i64;
        let h_i64 = h as i64;
        let mut ans: i64 = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            let mut total_hours: i64 = 0;
            for &pile in piles.iter() {
                let pile_i64 = pile as i64;
                total_hours += (pile_i64 + mid - 1) / mid;
                if total_hours > h_i64 {
                    break;
                }
            }

            if total_hours <= h_i64 {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans as i32
    }
}