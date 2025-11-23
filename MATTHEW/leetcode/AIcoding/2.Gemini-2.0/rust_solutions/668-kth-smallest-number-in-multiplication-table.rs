impl Solution {
    pub fn find_kth_number(m: i32, n: i32, k: i32) -> i32 {
        let mut low = 1;
        let mut high = m * n;

        while low <= high {
            let mid = low + (high - low) / 2;
            let mut count = 0;
            for i in 1..=m {
                count += std::cmp::min(mid / i, n);
            }

            if count < k {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        low
    }
}