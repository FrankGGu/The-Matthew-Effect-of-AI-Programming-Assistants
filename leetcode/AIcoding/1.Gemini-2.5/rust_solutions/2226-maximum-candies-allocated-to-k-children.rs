impl Solution {
    pub fn maximum_candies(candies: Vec<i32>, k: i64) -> i32 {
        let mut low: i64 = 1;
        let mut high: i64 = 0;
        for &c in &candies {
            if (c as i64) > high {
                high = c as i64;
            }
        }
        high += 1; 

        let mut ans: i64 = 0;

        while low < high {
            let mid = low + (high - low) / 2;

            let mut total_children: i64 = 0;
            for &pile in &candies {
                total_children += (pile as i64) / mid;
            }

            if total_children >= k {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        ans as i32
    }
}