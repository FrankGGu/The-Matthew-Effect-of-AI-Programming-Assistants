use std::collections::HashMap;

impl Solution {
    pub fn count_prefix_suffix_pairs(words: Vec<String>) -> i64 {
        let mut trie = HashMap::new();
        let mut count = 0;
        for word in words {
            let mut node = &mut trie;
            let word_bytes = word.as_bytes();
            let n = word_bytes.len();
            for i in 0..n {
                if i > 0 {
                    let mut temp_node = &trie;
                    let mut is_prefix = true;
                    for j in 0..i {
                        if let Some(next_node) = temp_node.get(&(word_bytes[j] as char)) {
                            temp_node = next_node;
                        } else {
                            is_prefix = false;
                            break;
                        }
                    }
                    if is_prefix {
                        let mut temp_node2 = &trie;
                        let mut is_suffix = true;
                        for j in 0..i {
                            if let Some(next_node) = temp_node2.get(&(word_bytes[n - i + j] as char)) {
                                temp_node2 = next_node;
                            } else {
                                is_suffix = false;
                                break;
                            }
                        }
                        if is_suffix {
                            if let Some(&c) = temp_node2.get(&(0 as char)) {
                                count += c;
                            }
                        }
                    }
                }

                if let Some(next_node) = node.get_mut(&(word_bytes[i] as char)) {
                    node = next_node;
                } else {
                    node.insert(word_bytes[i] as char, HashMap::new());
                    node = node.get_mut(&(word_bytes[i] as char)).unwrap();
                }
            }
            if let Some(&c) = node.get(&(0 as char)) {
                node.insert(0 as char, c + 1);
            } else {
                node.insert(0 as char, 1);
            }
        }
        count
    }
}

struct Solution {}