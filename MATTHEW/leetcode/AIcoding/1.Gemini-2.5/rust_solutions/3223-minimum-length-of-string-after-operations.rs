impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        let mut left = 0;
        let mut right = n - 1;

        while left < right && chars[left] == chars[right] {
            let current_char = chars[left];

            // Advance left pointer past all occurrences of current_char
            while left <= right && chars[left] == current_char {
                left += 1;
            }

            // Retreat right pointer past all occurrences of current_char
            while left <= right && chars[right] == current_char {
                right -= 1;
            }
        }

        // Calculate the length of the remaining string.
        // If left > right, it means the string became empty or was entirely removed.
        (right as i32 - left as i32 + 1).max(0)
    }
}