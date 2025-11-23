impl Solution {
    pub fn minimum_operations(num: String) -> i32 {
        let s = num.as_bytes();
        let n = s.len();
        let mut res = n;

        for i in (0..n).rev() {
            for j in (0..i).rev() {
                let num_val = (s[j] - b'0') * 10 + (s[i] - b'0');
                if num_val % 25 == 0 {
                    res = res.min(n - j - 2);
                }
            }
        }

        let count_zero = s.iter().filter(|&&c| c == b'0').count();
        if count_zero > 0 {
            res = res.min(n - 1);
        }

        if res == n {
            if count_zero > 0 {
                n as i32 - 1
            } else {
                n as i32
            }
        } else {
            res as i32
        }
    }
}