impl Solution {

use std::collections::{HashSet, VecDeque};

pub fn find_secret_word(mut possible_words: Vec<String>, master: &mut Master) {
    let mut candidates = possible_words.clone();
    let mut queue = VecDeque::new();
    for word in &candidates {
        queue.push_back(word.clone());
    }

    while !queue.is_empty() {
        let guess = queue.pop_front().unwrap();
        let match_count = master.guess(guess.clone());
        if match_count == 6 {
            return;
        }
        let mut new_queue = VecDeque::new();
        for candidate in &candidates {
            if are_similar(&guess, candidate, match_count) {
                new_queue.push_back(candidate.clone());
            }
        }
        candidates = new_queue.into_iter().collect();
        queue = new_queue;
    }
}

fn are_similar(a: &str, b: &str, match_count: i32) -> bool {
    let mut count = 0;
    for i in 0..a.len() {
        if a.chars().nth(i) == b.chars().nth(i) {
            count += 1;
        }
    }
    count == match_count
}

trait Master {
    fn guess(&mut self, word: String) -> i32;
}

struct Solution;

impl Solution {
    pub fn find_secret_word(possible_words: Vec<String>, master: &mut Master) {
        let mut candidates = possible_words.clone();
        let mut queue = VecDeque::new();
        for word in &candidates {
            queue.push_back(word.clone());
        }

        while !queue.is_empty() {
            let guess = queue.pop_front().unwrap();
            let match_count = master.guess(guess.clone());
            if match_count == 6 {
                return;
            }
            let mut new_queue = VecDeque::new();
            for candidate in &candidates {
                if are_similar(&guess, candidate, match_count) {
                    new_queue.push_back(candidate.clone());
                }
            }
            candidates = new_queue.into_iter().collect();
            queue = new_queue;
        }
    }
}
}