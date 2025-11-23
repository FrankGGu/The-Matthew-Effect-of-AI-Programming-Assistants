impl Solution {
    pub fn minimum_time(potions: Vec<i32>, target: i64) -> i32 {
        let mut left = 1;
        let mut right = *potions.iter().max().unwrap() as i64 * target;

        while left < right {
            let mid = left + (right - left) / 2;
            let total: i64 = potions.iter().map(|&x| mid / x as i64).sum();
            if total >= target {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left as i32
    }
}