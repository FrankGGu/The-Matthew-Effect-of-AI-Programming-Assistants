impl Solution {
    pub fn preimage_size(k: i32) -> i32 {
        fn count_trailing_zeros(n: i64) -> i64 {
            let mut count = 0;
            let mut i = 5;
            while n / i >= 1 {
                count += n / i;
                i *= 5;
            }
            count
        }

        fn find_k(k: i32) -> i64 {
            let mut low = 0;
            let mut high = 5 * (k as i64);
            let mut ans = -1;

            while low <= high {
                let mid = low + (high - low) / 2;
                let zeros = count_trailing_zeros(mid);

                if zeros >= k as i64 {
                    ans = mid;
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }
            ans
        }

        if k == 0 {
            5
        } else {
            if find_k(k + 1) == -1 || find_k(k) == -1 {
                5
            } else {
                (find_k(k + 1) - find_k(k)) as i32
            }
        }
    }
}