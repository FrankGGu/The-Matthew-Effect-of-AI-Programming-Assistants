impl Solution {
    pub fn reorder_spaces(text: String) -> String {
        let words: Vec<&str> = text.split_whitespace().collect();
        let space_count = text.chars().filter(|&c| c == ' ').count();
        let word_count = words.len();

        if word_count == 1 {
            return words[0].to_string() + &" ".repeat(space_count);
        }

        let spaces_between = space_count / (word_count - 1);
        let extra_spaces = space_count % (word_count - 1);

        let mut result = String::new();
        for i in 0..word_count - 1 {
            result.push_str(words[i]);
            result.push_str(&" ".repeat(spaces_between));
        }
        result.push_str(words[word_count - 1]);
        result.push_str(&" ".repeat(extra_spaces));

        result
    }
}