impl Solution {
    pub fn consecutive_numbers_sum(n: i32) -> i32 {
        let mut res = 0;
        let mut k = 1;
        while k * (k + 1) <= 2 * n {
            if (n - k * (k + 1) / 2) % k == 0 {
                res += 1;
            }
            k += 1;
        }
        res
    }
}