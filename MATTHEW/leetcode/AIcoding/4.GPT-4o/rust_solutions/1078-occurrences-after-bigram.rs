pub fn find_occurrences(text: String, first: String, second: String) -> Vec<String> {
    let words: Vec<&str> = text.split_whitespace().collect();
    let mut result = Vec::new();

    for i in 0..words.len() - 2 {
        if words[i] == first && words[i + 1] == second {
            result.push(words[i + 2].to_string());
        }
    }

    result
}