use std::collections::HashMap;

impl Solution {
    pub fn num_matching_subseq(s: String, words: Vec<String>) -> i32 {
        let mut map: HashMap<char, Vec<usize>> = HashMap::new();
        for (i, c) in s.chars().enumerate() {
            map.entry(c).or_insert_with(Vec::new).push(i);
        }

        let mut count = 0;
        for word in words {
            let mut prev = 0;
            let mut found = true;
            for c in word.chars() {
                if let Some(indices) = map.get(&c) {
                    match indices.binary_search(&prev) {
                        Ok(pos) => {
                            prev = indices[pos] + 1;
                        },
                        Err(pos) => {
                            if pos < indices.len() {
                                prev = indices[pos] + 1;
                            } else {
                                found = false;
                                break;
                            }
                        }
                    }
                } else {
                    found = false;
                    break;
                }
            }
            if found {
                count += 1;
            }
        }
        count
    }
}