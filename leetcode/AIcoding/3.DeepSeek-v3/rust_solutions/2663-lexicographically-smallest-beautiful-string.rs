impl Solution {
    pub fn smallest_beautiful_string(s: String, k: i32) -> String {
        let k = k as u8;
        let mut s = s.into_bytes();
        let n = s.len();
        let mut i = n as i32 - 1;

        while i >= 0 {
            s[i as usize] += 1;
            if s[i as usize] >= b'a' + k {
                if i == 0 {
                    return String::new();
                }
                s[i as usize] = b'a';
                i -= 1;
                continue;
            }
            if (i >= 1 && s[i as usize] == s[i as usize - 1]) || (i >= 2 && s[i as usize] == s[i as usize - 2]) {
                continue;
            }
            break;
        }

        for j in (i + 1) as usize..n {
            for c in b'a'..b'a' + k {
                if (j >= 1 && c == s[j - 1]) || (j >= 2 && c == s[j - 2]) {
                    continue;
                }
                s[j] = c;
                break;
            }
        }

        String::from_utf8(s).unwrap()
    }
}