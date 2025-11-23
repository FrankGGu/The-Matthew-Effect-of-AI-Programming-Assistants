impl Solution {
    pub fn to_goat_latin(s: String) -> String {
        let vowels = "aeiouAEIOU";
        let mut result = String::new();
        let words: Vec<&str> = s.split_whitespace().collect();

        for (i, word) in words.iter().enumerate() {
            let mut goat_word = String::from(*word);
            if vowels.contains(word.chars().next().unwrap()) {
                goat_word.push_str("ma");
            } else {
                let first_char = goat_word.remove(0);
                goat_word.push(first_char);
                goat_word.push_str("ma");
            }
            goat_word.push_str(&"a".repeat(i + 1));
            result.push_str(&goat_word);
            if i < words.len() - 1 {
                result.push(' ');
            }
        }

        result
    }
}