use std::collections::HashSet;

pub fn replace_words(dict: Vec<String>, sentence: String) -> String {
    let dict_set: HashSet<String> = dict.into_iter().collect();
    let mut result = Vec::new();

    for word in sentence.split_whitespace() {
        let mut prefix = word.to_string();
        for i in 1..=prefix.len() {
            if dict_set.contains(&prefix[..i].to_string()) {
                prefix = prefix[..i].to_string();
                break;
            }
        }
        result.push(prefix);
    }

    result.join(" ")
}