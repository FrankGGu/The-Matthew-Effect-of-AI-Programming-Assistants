use std::collections::HashMap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct WordFreq {
    word: String,
    freq: i32,
}

impl Ord for WordFreq {
    fn cmp(&self, other: &Self) -> Ordering {
        if self.freq == other.freq {
            other.word.cmp(&self.word)
        } else {
            self.freq.cmp(&other.freq)
        }
    }
}

impl PartialOrd for WordFreq {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn top_k_frequent(words: Vec<String>, k: i32) -> Vec<String> {
        let mut freq_map = HashMap::new();
        for word in words {
            *freq_map.entry(word).or_insert(0) += 1;
        }

        let mut heap = std::collections::BinaryHeap::new();
        for (word, freq) in freq_map {
            heap.push(WordFreq { word, freq });
        }

        let mut result = Vec::new();
        for _ in 0..k {
            if let Some(wf) = heap.pop() {
                result.push(wf.word);
            }
        }

        result
    }
}