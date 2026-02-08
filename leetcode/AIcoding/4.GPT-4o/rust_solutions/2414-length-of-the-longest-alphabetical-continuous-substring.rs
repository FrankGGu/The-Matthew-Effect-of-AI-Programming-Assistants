impl Solution {
    pub fn longest_continuousSubstring(s: String) -> i32 {
        let bytes = s.as_bytes();
        let mut max_length = 1;
        let mut current_length = 1;

        for i in 1..bytes.len() {
            if bytes[i] > bytes[i - 1] {
                current_length += 1;
            } else {
                max_length = max_length.max(current_length);
                current_length = 1;
            }
        }

        max_length.max(current_length)
    }
}