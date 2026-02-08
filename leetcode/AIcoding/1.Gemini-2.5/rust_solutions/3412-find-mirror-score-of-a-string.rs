impl Solution {
    fn get_mirror_char(c: char) -> Option<char> {
        match c {
            '0' => Some('0'),
            '1' => Some('1'),
            '6' => Some('9'),
            '8' => Some('8'),
            '9' => Some('6'),
            _ => None,
        }
    }

    pub fn find_mirror_score(s: String) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        if n == 0 {
            return 1;
        }

        let mut left = 0;
        let mut right = n - 1;

        while left <= right {
            let char_left = chars[left];
            let char_right = chars[right];

            if let Some(mirrored_left) = Self::get_mirror_char(char_left) {
                if mirrored_left != char_right {
                    return 0;
                }
            } else {
                return 0;
            }

            left += 1;
            right -= 1;
        }

        1
    }
}