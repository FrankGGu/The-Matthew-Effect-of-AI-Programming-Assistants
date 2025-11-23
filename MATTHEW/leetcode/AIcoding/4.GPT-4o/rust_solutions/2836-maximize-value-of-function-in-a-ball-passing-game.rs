impl Solution {
    pub fn max_value(n: i32, index: i32, max_sum: i32) -> i32 {
        let max_sum = max_sum as i64;
        let n = n as i64;
        let index = index as i64;

        let mut left = 1;
        let mut right = max_sum;

        while left < right {
            let mid = left + (right - left + 1) / 2;
            let left_count = index.min(mid - 1);
            let right_count = (n - 1 - index).min(mid - 1);

            let total = mid + (mid * (left_count as i64) - (left_count * (left_count + 1) / 2)) +
                (mid * (right_count as i64) - (right_count * (right_count + 1) / 2));

            if total <= max_sum {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        left as i32
    }
}