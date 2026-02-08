impl Solution {
    pub fn split_string(s: String) -> bool {
        let n = s.len();
        for len in 1..(n / 2 + 1) {
            let (mut cur, mut prev) = (0, 0);
            let mut valid = true;
            while cur + len <= n {
                let num: i64 = s[cur..cur + len].parse().unwrap();
                if cur == 0 || num + 1 == prev {
                    prev = num;
                    cur += len;
                } else {
                    valid = false;
                    break;
                }
            }
            if valid && cur == n {
                return true;
            }
        }
        false
    }
}