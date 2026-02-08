impl Solution {
    pub fn find_nth_value(n: i64, k: i64) -> i64 {
        if n <= k {
            n
        } else {
            let cycle_len = (n - 1) / k;
            if cycle_len % 2 == 0 {
                n % k
            } else {
                if n % k == 0 {
                    k
                } else {
                    k - (n % k)
                }
            }
        }
    }
}