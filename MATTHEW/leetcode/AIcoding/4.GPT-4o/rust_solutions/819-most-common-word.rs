use std::collections::HashMap;

pub fn most_common_word(paragraph: String, banned: Vec<String>) -> String {
    let mut word_count = HashMap::new();
    let banned_set: std::collections::HashSet<_> = banned.into_iter().collect();
    let mut cleaned_paragraph = String::new();

    for c in paragraph.chars() {
        if c.is_alphanumeric() {
            cleaned_paragraph.push(c.to_ascii_lowercase());
        } else {
            cleaned_paragraph.push(' ');
        }
    }

    for word in cleaned_paragraph.split_whitespace() {
        if !banned_set.contains(word) {
            *word_count.entry(word).or_insert(0) += 1;
        }
    }

    word_count.into_iter().max_by_key(|&(_, count)| count).unwrap().0.to_string()
}