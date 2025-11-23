impl Solution {
    pub fn max_value(n: i32, index: i32, max_sum: i32) -> i32 {
        let (n, index, max_sum) = (n as i64, index as i64, max_sum as i64);
        let mut left = 1;
        let mut right = max_sum;
        let mut result = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let left_sum = {
                let cnt = mid.min(index + 1);
                let sum = (mid + mid - cnt + 1) * cnt / 2;
                sum + (index + 1 - cnt).max(0)
            };
            let right_sum = {
                let cnt = mid.min(n - index);
                let sum = (mid + mid - cnt + 1) * cnt / 2;
                sum + (n - index - cnt).max(0)
            };
            let total = left_sum + right_sum - mid;
            if total <= max_sum {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        result as i32
    }
}