impl Solution {
    pub fn sort_string(s: String) -> String {
        let mut counts = [0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let mut result = String::with_capacity(s.len());
        let mut total_chars_added = 0;

        while total_chars_added < s.len() {
            // Increasing pass
            for i in 0..26 {
                if counts[i] > 0 {
                    result.push((b'a' + i as u8) as char);
                    counts[i] -= 1;
                    total_chars_added += 1;
                }
            }

            // Decreasing pass
            for i in (0..26).rev() {
                if counts[i] > 0 {
                    result.push((b'a' + i as u8) as char);
                    counts[i] -= 1;
                    total_chars_added += 1;
                }
            }
        }

        result
    }
}