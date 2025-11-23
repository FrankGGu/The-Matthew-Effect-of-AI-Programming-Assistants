impl Solution {
    pub fn maximum_candies(candies: Vec<i32>, k: i64) -> i32 {
        let mut left = 0;
        let mut right = *candies.iter().max().unwrap();
        while left < right {
            let mid = left + (right - left + 1) / 2;
            let mut total = 0i64;
            for &pile in &candies {
                total += (pile / mid) as i64;
                if total >= k {
                    break;
                }
            }
            if total >= k {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        left
    }
}