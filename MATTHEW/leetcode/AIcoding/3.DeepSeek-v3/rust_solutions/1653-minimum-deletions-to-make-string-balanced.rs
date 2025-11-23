impl Solution {
    pub fn minimum_deletions(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut a = vec![0; n + 1];
        let mut b = vec![0; n + 1];

        for i in 0..n {
            a[i + 1] = a[i] + if s[i] == b'b' { 1 } else { 0 };
        }

        for i in (0..n).rev() {
            b[i] = b[i + 1] + if s[i] == b'a' { 1 } else { 0 };
        }

        let mut res = std::i32::MAX;
        for i in 0..=n {
            res = res.min(a[i] + b[i]);
        }

        res
    }
}