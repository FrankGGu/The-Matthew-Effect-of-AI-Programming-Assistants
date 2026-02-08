impl Solution {
    pub fn rearrange_spaces(text: String) -> String {
        let words: Vec<&str> = text.split_whitespace().collect();
        let space_count = text.chars().filter(|&c| c == ' ').count();
        let word_count = words.len();

        if word_count == 0 {
            return String::new();
        }

        let spaces_between = if word_count == 1 { 0 } else { space_count / (word_count - 1) };
        let remaining_spaces = if word_count == 1 { space_count } else { space_count % (word_count - 1) };

        let mut result = String::new();
        for (i, &word) in words.iter().enumerate() {
            result.push_str(word);
            if i < word_count - 1 {
                result.push_str(&" ".repeat(spaces_between));
            }
        }
        result.push_str(&" ".repeat(remaining_spaces));

        result
    }
}