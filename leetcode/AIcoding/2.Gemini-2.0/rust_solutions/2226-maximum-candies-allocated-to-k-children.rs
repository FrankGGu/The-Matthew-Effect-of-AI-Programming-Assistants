impl Solution {
    pub fn maximum_candies(candies: Vec<i32>, k: i64) -> i32 {
        let mut left = 0;
        let mut right = *candies.iter().max().unwrap() as i64 + 1;

        while left < right {
            let mid = left + (right - left) / 2;
            if mid == 0 {
                return 0;
            }

            let mut count = 0;
            for &candy in &candies {
                count += candy as i64 / mid;
            }

            if count >= k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        (left - 1) as i32
    }
}