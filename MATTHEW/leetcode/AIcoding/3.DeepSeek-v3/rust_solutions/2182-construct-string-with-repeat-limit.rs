use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn repeat_limited_string(s: String, repeat_limit: i32) -> String {
        let mut freq = [0; 26];
        for c in s.chars() {
            freq[(c as u8 - b'a') as usize] += 1;
        }

        let mut max_heap = BinaryHeap::new();
        for i in 0..26 {
            if freq[i] > 0 {
                max_heap.push((i as u8, freq[i]));
            }
        }

        let mut result = Vec::new();
        while let Some((current_char, current_count)) = max_heap.pop() {
            let use_count = std::cmp::min(current_count, repeat_limit);
            for _ in 0..use_count {
                result.push(current_char);
            }
            let remaining = current_count - use_count;
            if remaining > 0 {
                if let Some((next_char, next_count)) = max_heap.pop() {
                    result.push(next_char);
                    if next_count > 1 {
                        max_heap.push((next_char, next_count - 1));
                    }
                    max_heap.push((current_char, remaining));
                } else {
                    break;
                }
            }
        }

        String::from_utf8(result).unwrap()
    }
}