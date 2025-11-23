impl Solution {
    pub fn moves_to_stamp(stamp: String, target: String) -> Vec<i32> {
        let s = stamp.as_bytes();
        let t = target.as_bytes();
        let m = s.len();
        let n = t.len();
        let mut stamped = vec![false; n];
        let mut res = Vec::new();
        let mut count = 0;

        while count < n {
            let mut found = false;
            for i in 0..=n - m {
                if !stamped[i] && can_stamp(s, t, i) {
                    res.push(i as i32);
                    for j in i..i + m {
                        if t[j] != b'?' {
                            count += 1;
                        }
                        t[j] = b'?';
                    }
                    stamped[i] = true;
                    found = true;
                }
            }
            if !found {
                return Vec::new();
            }
        }

        res.reverse();
        res
    }
}

fn can_stamp(s: &[u8], t: &[u8], start: usize) -> bool {
    let m = s.len();
    for i in 0..m {
        if t[start + i] != b'?' && t[start + i] != s[i] {
            return false;
        }
    }
    true
}