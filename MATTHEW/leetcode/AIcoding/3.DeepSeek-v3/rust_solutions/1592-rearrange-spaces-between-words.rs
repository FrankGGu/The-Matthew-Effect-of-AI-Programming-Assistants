impl Solution {
    pub fn reorder_spaces(text: String) -> String {
        let words: Vec<&str> = text.split_whitespace().collect();
        let space_count = text.chars().filter(|&c| c == ' ').count();
        let word_count = words.len();

        if word_count == 1 {
            return words[0].to_string() + &" ".repeat(space_count);
        }

        let gap = space_count / (word_count - 1);
        let rem = space_count % (word_count - 1);

        let mut res = String::new();
        for (i, word) in words.iter().enumerate() {
            res.push_str(word);
            if i < word_count - 1 {
                res.push_str(&" ".repeat(gap));
            }
        }
        res.push_str(&" ".repeat(rem));

        res
    }
}