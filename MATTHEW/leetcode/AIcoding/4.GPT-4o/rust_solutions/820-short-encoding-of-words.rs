pub fn minimum_length_encoding(words: Vec<String>) -> i32 {
    let mut suffixes = std::collections::HashSet::new();
    for word in &words {
        for i in 1..word.len() {
            suffixes.insert(&word[i..]);
        }
    }
    words.iter()
        .filter(|word| !suffixes.contains(*word))
        .map(|word| word.len() + 1)
        .sum::<usize>() as i32
}