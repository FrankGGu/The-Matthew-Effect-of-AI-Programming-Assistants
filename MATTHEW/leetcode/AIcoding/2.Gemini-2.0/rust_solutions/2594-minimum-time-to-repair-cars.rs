impl Solution {
    pub fn repair_cars(ranks: Vec<i32>, cars: i32) -> i64 {
        let mut left: i64 = 0;
        let mut right: i64 = *ranks.iter().min().unwrap() as i64 * (cars as i64).pow(2);
        let mut ans: i64 = right;

        while left <= right {
            let mid: i64 = left + (right - left) / 2;
            let mut count: i64 = 0;
            for &rank in &ranks {
                count += (mid as f64 / rank as f64).sqrt() as i64;
            }

            if count >= cars as i64 {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        ans
    }
}