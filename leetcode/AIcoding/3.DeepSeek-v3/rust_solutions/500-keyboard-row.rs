impl Solution {
    pub fn find_words(words: Vec<String>) -> Vec<String> {
        let rows = [
            "qwertyuiop".chars().collect::<std::collections::HashSet<_>>(),
            "asdfghjkl".chars().collect::<std::collections::HashSet<_>>(),
            "zxcvbnm".chars().collect::<std::collections::HashSet<_>>(),
        ];

        words.into_iter().filter(|word| {
            let lowercase_word = word.to_lowercase();
            let first_char = lowercase_word.chars().next().unwrap();
            let row = rows.iter().find(|row| row.contains(&first_char)).unwrap();
            lowercase_word.chars().all(|c| row.contains(&c))
        }).collect()
    }
}