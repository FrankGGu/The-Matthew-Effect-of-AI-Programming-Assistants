use std::collections::HashMap;

pub fn num_matching_subseq(s: String, words: Vec<String>) -> i32 {
    let mut buckets: HashMap<char, Vec<&str>> = HashMap::new();
    for word in &words {
        buckets.entry(word.chars().next().unwrap()).or_insert(Vec::new()).push(word);
    }

    let mut count = 0;
    for c in s.chars() {
        if let Some(matches) = buckets.remove(&c) {
            for word in matches {
                let mut it = word.chars();
                it.next(); // Remove the matched character
                if it.clone().count() == 0 {
                    count += 1;
                } else {
                    let next_char = it.next().unwrap();
                    buckets.entry(next_char).or_insert(Vec::new()).push(it.as_str());
                }
            }
        }
    }
    count
}