impl Solution {
    pub fn max_score(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut total_ones = 0;
        for &c in s_bytes.iter() {
            if c == b'1' {
                total_ones += 1;
            }
        }

        let mut max_score = 0;
        let mut zeros_left = 0;
        let mut ones_right = total_ones;

        // Iterate through all possible split points.
        // A split point 'i' means the left substring is s[0..i] and the right substring is s[i+1..n-1].
        // The loop variable 'i' represents the index of the last character of the left substring.
        // 'i' can range from 0 to n-2 to ensure both left and right substrings are non-empty.
        for i in 0..n - 1 {
            if s_bytes[i] == b'0' {
                zeros_left += 1;
            } else { // s_bytes[i] == b'1'
                ones_right -= 1;
            }
            // After processing s_bytes[i], it has been moved from the conceptual "right" part to the "left" part.
            // Calculate the score for the current split.
            max_score = max_score.max(zeros_left + ones_right);
        }

        max_score
    }
}