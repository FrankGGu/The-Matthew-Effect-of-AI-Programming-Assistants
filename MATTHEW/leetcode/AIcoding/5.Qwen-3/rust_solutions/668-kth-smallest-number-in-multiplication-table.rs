struct Solution;

impl Solution {
    pub fn find_kth_number(m: i32, n: i32, k: i32) -> i32 {
        let (mut left, mut right) = (1, m * n);

        while left < right {
            let mid = left + (right - left) / 2;
            let mut count = 0;

            for i in 1..=m {
                count += std::cmp::min(mid / i, n);
                if count >= k {
                    break;
                }
            }

            if count >= k {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        left
    }
}