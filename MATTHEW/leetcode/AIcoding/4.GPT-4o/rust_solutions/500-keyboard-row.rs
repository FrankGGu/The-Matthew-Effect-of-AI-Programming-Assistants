impl Solution {
    pub fn find_words(words: Vec<String>) -> Vec<String> {
        let rows = vec![
            "qwertyuiop".chars().collect::<std::collections::HashSet<_>>(),
            "asdfghjkl".chars().collect::<std::collections::HashSet<_>>(),
            "zxcvbnm".chars().collect::<std::collections::HashSet<_>>(),
        ];

        words.into_iter()
            .filter(|word| {
                let chars = word.to_lowercase().chars().collect::<std::collections::HashSet<_>>();
                rows.iter().any(|row| chars.is_subset(row))
            })
            .collect()
    }
}