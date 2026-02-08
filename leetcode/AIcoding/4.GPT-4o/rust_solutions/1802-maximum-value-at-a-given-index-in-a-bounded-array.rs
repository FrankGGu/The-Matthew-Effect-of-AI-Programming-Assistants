impl Solution {
    pub fn max_value(n: i32, index: i32, max_sum: i32) -> i32 {
        let n = n as i64;
        let index = index as i64;
        let max_sum = max_sum as i64;

        let mut left = 1;
        let mut right = max_sum;

        while left < right {
            let mid = (left + right + 1) / 2;
            let total = Self::calculate_sum(n, index, mid);
            if total <= max_sum {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left as i32
    }

    fn calculate_sum(n: i64, index: i64, value: i64) -> i64 {
        let left_len = index;
        let right_len = n - index - 1;

        let left = if left_len + 1 >= value {
            value * (value + 1) / 2
        } else {
            let left_sum = left_len * (left_len + 1) / 2;
            let remaining = value - left_len;
            left_sum + remaining * (remaining + 1) / 2
        };

        let right = if right_len + 1 >= value {
            value * (value + 1) / 2
        } else {
            let right_sum = right_len * (right_len + 1) / 2;
            let remaining = value - right_len;
            right_sum + remaining * (remaining + 1) / 2
        };

        left + right + value
    }
}