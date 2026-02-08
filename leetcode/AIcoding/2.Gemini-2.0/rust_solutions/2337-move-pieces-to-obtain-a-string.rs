impl Solution {
    pub fn can_change(start: String, target: String) -> bool {
        let s: Vec<char> = start.chars().collect();
        let t: Vec<char> = target.chars().collect();

        let mut i = 0;
        let mut j = 0;

        while i < s.len() && j < t.len() {
            while i < s.len() && s[i] == '_' {
                i += 1;
            }
            while j < t.len() && t[j] == '_' {
                j += 1;
            }

            if i == s.len() && j == t.len() {
                return true;
            }
            if i == s.len() || j == t.len() {
                return false;
            }

            if s[i] != t[j] {
                return false;
            }

            if s[i] == 'L' {
                if i < j {
                    return false;
                }
            } else {
                if i > j {
                    return false;
                }
            }

            i += 1;
            j += 1;
        }

        while i < s.len() {
            if s[i] != '_' {
                return false;
            }
            i += 1;
        }
        while j < t.len() {
            if t[j] != '_' {
                return false;
            }
            j += 1;
        }

        true
    }
}