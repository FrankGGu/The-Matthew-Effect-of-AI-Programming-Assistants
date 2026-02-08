impl Solution {
    pub fn is_transformable(s: String, t: String) -> bool {
        let s: Vec<char> = s.chars().collect();
        let t: Vec<char> = t.chars().collect();
        let m = s.len();
        let n = t.len();
        if m < n {
            return false;
        }
        let mut s_ptr = 0;
        let mut t_ptr = 0;

        while t_ptr < n {
            let mut found = false;
            while s_ptr < m {
                if s[s_ptr] == t[t_ptr] {
                    found = true;
                    let mut valid = true;
                    for k in t_ptr + 1..n {
                        if t[k] == t[t_ptr] {
                            break;
                        }
                    }

                    for k in s_ptr + 1..m {
                        if s[k] == t[t_ptr] {
                            break;
                        }
                        if s[k] as u8 < t[t_ptr] as u8 {
                            valid = false;
                            break;
                        }
                    }

                    if valid {
                         s_ptr += 1;
                         t_ptr += 1;
                         break;
                    } else {
                         s_ptr += 1;
                    }
                } else {
                    s_ptr += 1;
                }
            }
            if !found {
                return false;
            }
            if s_ptr > m {
                return false;
            }
        }
        true
    }
}