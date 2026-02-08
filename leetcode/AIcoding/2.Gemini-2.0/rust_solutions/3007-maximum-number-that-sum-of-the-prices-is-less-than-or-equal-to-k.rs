impl Solution {
    pub fn maximum_number_that_sum_of_the_prices_is_less_than_or_equal_to_k(n: i64, k: i64) -> i64 {
        let mut low = 0;
        let mut high = n;
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            let mut count = 0;
            let mut p = 1;
            while p <= mid {
                count += mid - p + 1;
                if p > mid / 2 {
                    break;
                }
                p *= 2;
            }

            if count <= k {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        ans
    }
}