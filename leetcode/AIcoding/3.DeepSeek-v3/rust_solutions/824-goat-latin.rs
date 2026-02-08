impl Solution {
    pub fn to_goat_latin(sentence: String) -> String {
        let vowels: std::collections::HashSet<char> = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U']
            .iter()
            .cloned()
            .collect();
        let mut res = Vec::new();
        for (i, word) in sentence.split_whitespace().enumerate() {
            let mut new_word = String::new();
            let first_char = word.chars().next().unwrap();
            if vowels.contains(&first_char) {
                new_word.push_str(word);
            } else {
                new_word.push_str(&word[1..]);
                new_word.push(first_char);
            }
            new_word.push_str("ma");
            new_word.push_str(&"a".repeat(i + 1));
            res.push(new_word);
        }
        res.join(" ")
    }
}