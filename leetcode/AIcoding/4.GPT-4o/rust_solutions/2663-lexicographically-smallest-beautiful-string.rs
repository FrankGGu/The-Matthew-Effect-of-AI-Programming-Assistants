impl Solution {
    pub fn smallest_beautiful_string(s: String, k: i32) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();
        let k = k as usize;

        for i in (0..n).rev() {
            if s[i] != (b'a' + k as u8 - 1) as char {
                s[i] = (s[i] as u8 + 1) as char;
                for j in (i + 1)..n {
                    s[j] = 'a';
                }
                if Self::is_beautiful(&s, k) {
                    return s.iter().collect();
                }
                while s[i] < (b'a' + k as u8 - 1) as char {
                    s[i] = (s[i] as u8 + 1) as char;
                    if Self::is_beautiful(&s, k) {
                        return s.iter().collect();
                    }
                }
            }
        }

        if s[0] == (b'a' + k as u8 - 1) as char {
            return String::new();
        }

        s[0] = (s[0] as u8 + 1) as char;
        for j in 1..n {
            s[j] = 'a';
        }
        if Self::is_beautiful(&s, k) {
            return s.iter().collect();
        }

        String::new()
    }

    fn is_beautiful(s: &[char], k: usize) -> bool {
        let mut count = vec![0; k];
        for &c in s {
            let idx = (c as u8 - b'a') as usize;
            count[idx] += 1;
            if count[idx] > 1 {
                return false;
            }
            if idx > 0 && count[idx - 1] == 0 {
                return false;
            }
            if idx < k - 1 && count[idx + 1] == 0 {
                return false;
            }
        }
        true
    }
}