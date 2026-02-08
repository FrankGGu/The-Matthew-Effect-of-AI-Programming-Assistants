impl Solution {
    pub fn find_words(words: Vec<String>) -> Vec<String> {
        let rows = vec![
            "qwertyuiop".chars().collect::<std::collections::HashSet<_>>(),
            "asdfghjkl".chars().collect::<std::collections::HashSet<_>>(),
            "zxcvbnm".chars().collect::<std::collections::HashSet<_>>(),
        ];

        words
            .into_iter()
            .filter(|word| {
                let lower_word = word.to_lowercase();
                let chars: std::collections::HashSet<_> = lower_word.chars().collect();
                rows.iter().any(|row| chars.is_subset(row))
            })
            .collect()
    }
}