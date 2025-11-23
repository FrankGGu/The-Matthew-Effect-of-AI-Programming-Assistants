impl Solution {
    pub fn preimage_size_fzf(k: i32) -> i32 {
        let mut left = 0;
        let mut right = 5 * (k as i64 + 1);
        while left <= right {
            let mid = left + (right - left) / 2;
            let zeros = Self::trailing_zeros(mid);
            if zeros == k as i64 {
                return 5;
            } else if zeros < k as i64 {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        0
    }

    fn trailing_zeros(mut n: i64) -> i64 {
        let mut count = 0;
        while n > 0 {
            n /= 5;
            count += n;
        }
        count
    }
}