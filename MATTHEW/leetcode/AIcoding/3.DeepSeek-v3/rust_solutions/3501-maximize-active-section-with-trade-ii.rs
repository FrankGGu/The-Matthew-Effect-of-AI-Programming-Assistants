impl Solution {
    pub fn max_active_sections(trades: Vec<i32>, k: i32) -> i32 {
        let n = trades.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + trades[i];
        }

        let mut res = 0;
        let mut left = 0;
        for right in 0..n {
            while prefix[right + 1] - prefix[left] < -k {
                left += 1;
            }
            res = res.max(right - left + 1);
        }
        res as i32
    }
}