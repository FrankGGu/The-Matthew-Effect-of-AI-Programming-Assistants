use std::collections::HashSet;

pub fn longest_word(words: Vec<String>) -> String {
    let mut word_set: HashSet<String> = words.iter().cloned().collect();
    let mut longest = String::new();

    for word in &words {
        if word.len() > longest.len() || (word.len() == longest.len() && word < &longest) {
            let mut valid = true;
            for i in 1..word.len() {
                if !word_set.contains(&word[0..i].to_string()) {
                    valid = false;
                    break;
                }
            }
            if valid {
                longest = word.clone();
            }
        }
    }
    longest
}