impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn num_matching_subseq(s: String, words: Vec<String>) -> i32 {
        let mut queue = HashMap::new();
        for c in 'a'..='z' {
            queue.insert(c, VecDeque::new());
        }
        for word in &words {
            if let Some(first_char) = word.chars().next() {
                queue.get_mut(&first_char).unwrap().push_back(word);
            }
        }
        let s_chars: Vec<char> = s.chars().collect();
        let mut count = 0;
        for c in s_chars {
            let mut q = queue.get_mut(&c).unwrap().clone();
            while let Some(word) = q.pop_front() {
                if let Some(next_char) = word.chars().nth(1) {
                    queue.get_mut(&next_char).unwrap().push_back(word);
                } else {
                    count += 1;
                }
            }
            *queue.get_mut(&c).unwrap() = q;
        }
        count
    }
}
}