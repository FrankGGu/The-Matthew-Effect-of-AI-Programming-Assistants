impl Solution {
    pub fn min_time(time: Vec<i32>, m: i32) -> i32 {
        let mut left = 0;
        let mut right = time.iter().sum::<i32>();
        while left < right {
            let mid = left + (right - left) / 2;
            if Self::check(&time, m, mid) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        left
    }

    fn check(time: &[i32], m: i32, limit: i32) -> bool {
        let mut days = 1;
        let mut sum = 0;
        let mut max = 0;
        for &t in time {
            sum += t;
            max = max.max(t);
            if sum - max > limit {
                days += 1;
                sum = t;
                max = t;
                if days > m {
                    return false;
                }
            }
        }
        true
    }
}