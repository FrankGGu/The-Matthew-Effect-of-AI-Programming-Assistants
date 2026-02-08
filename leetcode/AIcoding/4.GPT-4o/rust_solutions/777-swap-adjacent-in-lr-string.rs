impl Solution {
    pub fn can_transform(start: String, end: String) -> bool {
        let (mut i, mut j) = (0, 0);
        let (n, m) = (start.len(), end.len());

        while i < n || j < m {
            while i < n && start.chars().nth(i) == Some('X') {
                i += 1;
            }
            while j < m && end.chars().nth(j) == Some('X') {
                j += 1;
            }

            if i < n && j < m {
                if start.chars().nth(i) != end.chars().nth(j) {
                    return false;
                }
                if start.chars().nth(i) == Some('L') && i < j {
                    return false;
                }
                if start.chars().nth(i) == Some('R') && i > j {
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