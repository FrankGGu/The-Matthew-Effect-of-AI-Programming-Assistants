impl Solution {
    pub fn can_transform(start: String, end: String) -> bool {
        if start.len() != end.len() {
            return false;
        }

        let start_no_x: String = start.chars().filter(|&c| c != 'X').collect();
        let end_no_x: String = end.chars().filter(|&c| c != 'X').collect();

        if start_no_x != end_no_x {
            return false;
        }

        let mut start_idx = 0;
        let mut end_idx = 0;

        while start_idx < start.len() && end_idx < end.len() {
            while start_idx < start.len() && start.chars().nth(start_idx).unwrap() == 'X' {
                start_idx += 1;
            }
            while end_idx < end.len() && end.chars().nth(end_idx).unwrap() == 'X' {
                end_idx += 1;
            }

            if start_idx == start.len() && end_idx == end.len() {
                return true;
            }
            if start_idx == start.len() || end_idx == end.len() {
                return false;
            }

            let start_char = start.chars().nth(start_idx).unwrap();
            let end_char = end.chars().nth(end_idx).unwrap();

            if start_char != end_char {
                return false;
            }

            if start_char == 'L' {
                if start_idx < end_idx {
                    return false;
                }
            } else if start_char == 'R' {
                if start_idx > end_idx {
                    return false;
                }
            }

            start_idx += 1;
            end_idx += 1;
        }

        true
    }
}