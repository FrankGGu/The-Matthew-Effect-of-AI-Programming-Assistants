struct Solution;

impl Solution {
    pub fn compress(word: String) -> String {
        let mut result = String::with_capacity(word.len());
        let chars: Vec<char> = word.chars().collect();
        let n = chars.len();
        let mut i = 0;

        while i < n {
            let current_char = chars[i];
            let mut count = 0;
            let mut j = i;

            // Count consecutive occurrences of current_char
            while j < n && chars[j] == current_char {
                count += 1;
                j += 1;
            }

            // Apply compression rules
            if count >= 3 {
                result.push(current_char);
                result.push_str(&count.to_string());
            } else {
                // count is 1 or 2, keep as is
                for _ in 0..count {
                    result.push(current_char);
                }
            }

            // Move to the start of the next group
            i = j;
        }

        result
    }
}