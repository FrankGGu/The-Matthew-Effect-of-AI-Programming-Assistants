impl Solution {

use std::collections::HashMap;

fn main() {
    let paragraph = "Bob hit a ball, the LITTLE ball went up to the wall.";
    let banned = vec!["hit", "the", "a", "ball", "up", "to", "the"];
    println!("{}", most_common_word(paragraph, banned));
}

fn most_common_word(paragraph: String, mut banned: Vec<String>) -> String {
    let mut word_count = HashMap::new();
    let mut max_count = 0;
    let mut most_common = String::new();

    let mut word = String::new();
    for c in paragraph.chars() {
        if c.is_alphabetic() {
            word.push(c.to_lowercase().next().unwrap());
        } else if !word.is_empty() {
            let word_str = word.clone();
            word.clear();
            if !banned.contains(&word_str) {
                *word_count.entry(word_str).or_insert(0) += 1;
                if *word_count.get(&word_str).unwrap() > max_count {
                    max_count = *word_count.get(&word_str).unwrap();
                    most_common = word_str;
                }
            }
        }
    }

    if !word.is_empty() {
        let word_str = word.clone();
        if !banned.contains(&word_str) {
            *word_count.entry(word_str).or_insert(0) += 1;
            if *word_count.get(&word_str).unwrap() > max_count {
                most_common = word_str;
            }
        }
    }

    most_common
}
}