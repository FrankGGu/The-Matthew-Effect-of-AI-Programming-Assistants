impl Solution {
    pub fn minimum_partition(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let k = k as i64;
        let mut res = 1;
        let mut current: i64 = 0;

        for &c in s {
            let digit = (c - b'0') as i64;
            if digit > k {
                return -1;
            }
            if current * 10 + digit > k {
                res += 1;
                current = digit;
            } else {
                current = current * 10 + digit;
            }
        }
        res
    }
}