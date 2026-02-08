impl Solution {
    pub fn smallest_string(s: String) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut start = None;
        for i in 0..chars.len() {
            if chars[i] != 'a' {
                start = Some(i);
                break;
            }
        }

        match start {
            Some(start_index) => {
                let mut end = start_index;
                while end < chars.len() && chars[end] != 'a' {
                    chars[end] = ((chars[end] as u8 - b'a' - 1 + 26) % 26 + b'a') as char;
                    end += 1;
                }
            }
            None => {
                chars[chars.len() - 1] = 'z';
            }
        }

        chars.into_iter().collect()
    }
}