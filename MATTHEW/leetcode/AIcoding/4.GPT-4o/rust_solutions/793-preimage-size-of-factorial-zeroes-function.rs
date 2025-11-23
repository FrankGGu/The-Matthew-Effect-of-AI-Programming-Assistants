impl Solution {
    pub fn preimage_size_fzf(k: i32) -> i32 {
        fn count_zeroes(n: i64) -> i64 {
            let mut count = 0;
            let mut x = n;
            while x > 0 {
                x /= 5;
                count += x;
            }
            count
        }

        let mut left = 0;
        let mut right = 5 * (k + 1);

        while left < right {
            let mid = (left + right) / 2;
            if count_zeroes(mid) < k as i64 {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        if count_zeroes(left) == k as i64 {
            5
        } else {
            0
        }
    }
}