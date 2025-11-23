use std::collections::{HashSet, HashMap, VecDeque};

pub fn find_ladders(begin_word: String, end_word: String, word_list: Vec<String>) -> Vec<Vec<String>> {
    let word_set: HashSet<String> = word_list.iter().cloned().collect();
    if !word_set.contains(&end_word) {
        return vec![];
    }

    let mut adj: HashMap<String, Vec<String>> = HashMap::new();
    let mut layer: HashMap<String, Vec<String>> = HashMap::new();
    layer.insert(begin_word.clone(), vec![begin_word.clone()]);

    let mut found = false;
    let mut visited = HashSet::new();
    visited.insert(begin_word.clone());

    let mut queue = VecDeque::new();
    queue.push_back(begin_word);

    while !queue.is_empty() && !found {
        let mut current_level_visited = HashSet::new();
        let level_size = queue.len();

        for _ in 0..level_size {
            let word = queue.pop_front().unwrap();
            let word_chars: Vec<char> = word.chars().collect();

            for i in 0..word.len() {
                let original_char = word_chars[i];

                for c in 'a'..='z' {
                    if c == original_char {
                        continue;
                    }
                    let mut new_word_chars = word_chars.clone();
                    new_word_chars[i] = c;
                    let new_word: String = new_word_chars.iter().collect();

                    if word_set.contains(&new_word) {
                        adj.entry(word.clone()).or_default().push(new_word.clone());

                        if !visited.contains(&new_word) {
                            current_level_visited.insert(new_word.clone());
                            queue.push_back(new_word.clone());
                        }

                        if !layer.contains_key(&new_word) {
                            let mut paths = layer.get(&word).unwrap().clone();
                            paths.push(new_word.clone());
                            layer.insert(new_word.clone(), paths);
                        }

                        if new_word == end_word {
                            found = true;
                        }
                    }
                }
            }
        }

        visited.extend(current_level_visited);
    }

    layer.get(&end_word).map_or(vec![], |paths| paths.iter().map(|p| p.clone()).collect())
}