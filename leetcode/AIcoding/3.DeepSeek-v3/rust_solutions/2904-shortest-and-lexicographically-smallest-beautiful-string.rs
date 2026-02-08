impl Solution {
    pub fn shortest_beautiful_substring(s: String, k: i32) -> String {
        let s = s.as_bytes();
        let k = k as usize;
        let mut min_len = usize::MAX;
        let mut result = String::new();
        let mut left = 0;
        let mut count = 0;

        for right in 0..s.len() {
            if s[right] == b'1' {
                count += 1;
            }
            while count == k {
                let current_len = right - left + 1;
                if current_len < min_len {
                    min_len = current_len;
                    result = String::from_utf8(s[left..=right].to_vec()).unwrap();
                } else if current_len == min_len {
                    let candidate = String::from_utf8(s[left..=right].to_vec()).unwrap();
                    if candidate < result {
                        result = candidate;
                    }
                }
                if s[left] == b'1' {
                    count -= 1;
                }
                left += 1;
            }
        }

        result
    }
}