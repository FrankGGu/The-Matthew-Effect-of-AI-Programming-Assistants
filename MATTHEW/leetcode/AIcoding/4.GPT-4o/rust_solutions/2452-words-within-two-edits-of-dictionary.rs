use std::collections::HashSet;

pub fn two_edit_words(queries: Vec<String>, dictionary: Vec<String>) -> Vec<String> {
    let mut result = Vec::new();

    for query in queries {
        for word in &dictionary {
            if is_within_two_edits(&query, word) {
                result.push(query.clone());
                break;
            }
        }
    }

    result
}

fn is_within_two_edits(word1: &String, word2: &String) -> bool {
    if (word1.len() as i32 - word2.len() as i32).abs() > 2 {
        return false;
    }

    let mut edits = 0;
    let mut i = 0;
    let mut j = 0;

    while i < word1.len() && j < word2.len() {
        if word1.as_bytes()[i] != word2.as_bytes()[j] {
            edits += 1;
            if edits > 2 {
                return false;
            }
            if word1.len() > word2.len() {
                i += 1;
            } else if word1.len() < word2.len() {
                j += 1;
            } else {
                i += 1;
                j += 1;
            }
        } else {
            i += 1;
            j += 1;
        }
    }

    edits + (word1.len() as i32 - i as i32) + (word2.len() as i32 - j as i32) <= 2
}