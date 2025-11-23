impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let bytes = s.as_bytes();
        let n = bytes.len();
        let mut left = 0;
        let mut right = n as i32 - 1;

        while left < right {
            if bytes[left as usize] == bytes[right as usize] {
                let ch = bytes[left as usize];
                while left <= right && bytes[left as usize] == ch {
                    left += 1;
                }
                while left <= right && bytes[right as usize] == ch {
                    right -= 1;
                }
            } else {
                break;
            }
        }

        (right - left + 1) as i32
    }
}