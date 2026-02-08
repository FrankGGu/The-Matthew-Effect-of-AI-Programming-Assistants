impl Solution {
    pub fn repair_cars(ranks: Vec<i32>, cars: i32) -> i64 {
        let mut left = 1i64;
        let mut right = {
            let max_rank = *ranks.iter().max().unwrap() as i64;
            max_rank * cars as i64 * cars as i64
        };

        while left < right {
            let mid = left + (right - left) / 2;
            let total = ranks.iter().map(|&r| {
                let r = r as i64;
                ((mid / r) as f64).sqrt() as i64
            }).sum::<i64>();

            if total < cars as i64 {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}