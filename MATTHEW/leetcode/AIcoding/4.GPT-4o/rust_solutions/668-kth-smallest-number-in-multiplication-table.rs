impl Solution {
    pub fn find_kth_number(m: i32, n: i32, k: i32) -> i32 {
        let (mut left, mut right) = (1, m * n);
        while left < right {
            let mid = left + (right - left) / 2;
            let count = (1..=m).map(|x| (mid / x).min(n)).sum::<i32>();
            if count < k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        left
    }
}