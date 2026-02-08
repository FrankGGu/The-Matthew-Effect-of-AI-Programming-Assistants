pub fn longest_palindrome(s: String) -> String {
    let bytes = s.as_bytes();
    let mut start = 0;
    let mut max_len = 1;

    for i in 0..s.len() {
        let mut left = i as isize;
        let mut right = i as isize;

        while left >= 0 && right < s.len() as isize && bytes[left as usize] == bytes[right as usize] {
            if right - left + 1 > max_len {
                max_len = right - left + 1;
                start = left as usize;
            }
            left -= 1;
            right += 1;
        }

        left = i as isize;
        right = i as isize + 1;

        while left >= 0 && right < s.len() as isize && bytes[left as usize] == bytes[right as usize] {
            if right - left + 1 > max_len {
                max_len = right - left + 1;
                start = left as usize;
            }
            left -= 1;
            right += 1;
        }
    }

    s[start..start + max_len].to_string()
}