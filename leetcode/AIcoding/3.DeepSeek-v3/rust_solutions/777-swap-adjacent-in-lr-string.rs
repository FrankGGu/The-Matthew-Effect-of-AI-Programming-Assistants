impl Solution {
    pub fn can_transform(start: String, end: String) -> bool {
        let start_chars: Vec<char> = start.chars().collect();
        let end_chars: Vec<char> = end.chars().collect();
        let n = start_chars.len();
        if n != end_chars.len() {
            return false;
        }
        let (mut i, mut j) = (0, 0);
        while i < n && j < n {
            while i < n && start_chars[i] == 'X' {
                i += 1;
            }
            while j < n && end_chars[j] == 'X' {
                j += 1;
            }
            if i == n || j == n {
                break;
            }
            if start_chars[i] != end_chars[j] {
                return false;
            }
            if start_chars[i] == 'L' && i < j {
                return false;
            }
            if start_chars[i] == 'R' && i > j {
                return false;
            }
            i += 1;
            j += 1;
        }
        while i < n {
            if start_chars[i] != 'X' {
                return false;
            }
            i += 1;
        }
        while j < n {
            if end_chars[j] != 'X' {
                return false;
            }
            j += 1;
        }
        true
    }
}