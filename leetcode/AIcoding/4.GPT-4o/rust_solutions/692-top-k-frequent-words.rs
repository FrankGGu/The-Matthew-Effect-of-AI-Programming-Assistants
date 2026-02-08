use std::collections::HashMap;
use std::collections::BinaryHeap;

pub fn top_k_frequent(words: Vec<String>, k: i32) -> Vec<String> {
    let mut count = HashMap::new();
    for word in words {
        *count.entry(word).or_insert(0) += 1;
    }

    let mut heap = BinaryHeap::new();
    for (word, freq) in count {
        heap.push((std::cmp::Reverse(freq), word));
        if heap.len() > k as usize {
            heap.pop();
        }
    }

    let mut result: Vec<String> = heap.into_iter().map(|(_, word)| word).collect();
    result.sort();
    result.reverse();
    result
}