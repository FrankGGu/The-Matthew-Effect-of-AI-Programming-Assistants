struct Solution;

impl Solution {
    fn trailing_zeroes(mut n: i64) -> i64 {
        let mut count = 0;
        while n >= 5 {
            n /= 5;
            count += n;
        }
        count
    }

    fn find_x_lower_bound(target_k: i64) -> i64 {
        let mut low = 0;
        // A sufficiently large upper bound for x.
        // For k = 10^9, x is approximately 4 * 10^9.
        // 5 * 10^9 is a safe upper bound.
        let mut high = 5_000_000_000i64; 

        while low < high {
            let mid = low + (high - low) / 2;
            if Solution::trailing_zeroes(mid) < target_k {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        low
    }

    pub fn preimage_size_f_of_x(k: i32) -> i32 {
        let k_i64 = k as i64;

        let x_start = Solution::find_x_lower_bound(k_i64);

        if Solution::trailing_zeroes(x_start) != k_i64 {
            return 0;
        } else {
            let x_next_k = Solution::find_x_lower_bound(k_i64 + 1);
            return (x_next_k - x_start) as i32;
        }
    }
}