impl Solution {
    pub fn remove_almost_equal_characters(word: String) -> i32 {
        let mut word_chars: Vec<char> = word.chars().collect();
        let mut changes = 0;
        let n = word_chars.len();

        for i in 1..n {
            if word_chars[i] == word_chars[i - 1] || 
               (word_chars[i] as i32 - word_chars[i - 1] as i32).abs() == 1 {
                changes += 1;
                word_chars[i] = '#'; // Mark as changed to avoid affecting next comparison
            }
        }

        changes
    }
}