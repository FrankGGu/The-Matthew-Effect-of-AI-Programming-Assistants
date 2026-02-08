impl Solution {
    pub fn can_change(start: String, target: String) -> bool {
        let (s, t) = (start.as_bytes(), target.as_bytes());
        let (n, m) = (s.len(), t.len());
        if n != m {
            return false;
        }

        let mut i = 0;
        let mut j = 0;

        while i < n || j < m {
            while i < n && s[i] == b'_'{ i += 1; }
            while j < m && t[j] == b'_'{ j += 1; }
            if i < n && j < m {
                if s[i] != t[j] {
                    return false;
                }
                if s[i] == b'L' && i < j {
                    return false;
                }
                if s[i] == b'R' && i > j {
                    return false;
                }
                i += 1;
                j += 1;
            } else if i < n || j < m {
                return false;
            }
        }
        true
    }
}