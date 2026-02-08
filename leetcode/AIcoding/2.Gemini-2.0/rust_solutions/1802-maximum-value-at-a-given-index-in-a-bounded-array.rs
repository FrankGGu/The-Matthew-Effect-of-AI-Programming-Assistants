impl Solution {
    pub fn max_value(n: i32, index: i32, max_sum: i32) -> i32 {
        let n = n as i64;
        let index = index as i64;
        let max_sum = max_sum as i64;

        let mut left = 1;
        let mut right = max_sum;
        let mut ans = 0;

        while left <= right {
            let mid = left + (right - left) / 2;

            let mut sum = mid;

            if mid > index {
                sum += (mid - 1 + mid - index) * index / 2;
            } else {
                sum += (mid - 1) * mid / 2;
                sum += index - mid + 1;
            }

            if mid > n - 1 - index {
                sum += (mid - 1 + mid - (n - 1 - index)) * (n - 1 - index) / 2;
            } else {
                sum += (mid - 1) * mid / 2;
                sum += n - 1 - index - mid + 1;
            }

            sum -= mid - 1;

            if sum <= max_sum {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        ans as i32
    }
}