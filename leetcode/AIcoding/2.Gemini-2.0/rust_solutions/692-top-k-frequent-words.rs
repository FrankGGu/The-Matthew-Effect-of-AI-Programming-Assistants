use std::collections::HashMap;
use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct WordCount {
    word: String,
    count: i32,
}

impl Ord for WordCount {
    fn cmp(&self, other: &Self) -> Ordering {
        if self.count != other.count {
            other.count.cmp(&self.count)
        } else {
            self.word.cmp(&other.word)
        }
    }
}

impl PartialOrd for WordCount {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn top_k_frequent(words: Vec<String>, k: i32) -> Vec<String> {
        let mut counts: HashMap<String, i32> = HashMap::new();
        for word in &words {
            *counts.entry(word.clone()).or_insert(0) += 1;
        }

        let mut heap: BinaryHeap<WordCount> = BinaryHeap::new();
        for (word, count) in counts {
            heap.push(WordCount { word: word, count: count });
        }

        let mut result: Vec<String> = Vec::new();
        for _ in 0..k {
            if let Some(word_count) = heap.pop() {
                result.push(word_count.word);
            }
        }

        result
    }
}

struct Solution;