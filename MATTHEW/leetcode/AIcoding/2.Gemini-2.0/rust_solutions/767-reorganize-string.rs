use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct CharCount {
    ch: char,
    count: i32,
}

impl Ord for CharCount {
    fn cmp(&self, other: &Self) -> Ordering {
        self.count.cmp(&other.count)
    }
}

impl PartialOrd for CharCount {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn reorganize_string(s: String) -> String {
        let mut counts = std::collections::HashMap::new();
        for ch in s.chars() {
            *counts.entry(ch).or_insert(0) += 1;
        }

        let mut heap = BinaryHeap::new();
        for (ch, count) in counts {
            heap.push(CharCount { ch, count });
        }

        let mut result = String::new();
        let mut prev = None;

        while let Some(mut curr) = heap.pop() {
            result.push(curr.ch);
            curr.count -= 1;

            if let Some(mut prev_char) = prev {
                if prev_char.count > 0 {
                    heap.push(prev_char);
                }
            }

            prev = Some(curr);
        }

        if result.len() == s.len() {
            result
        } else {
            "".to_string()
        }
    }
}

struct Solution;