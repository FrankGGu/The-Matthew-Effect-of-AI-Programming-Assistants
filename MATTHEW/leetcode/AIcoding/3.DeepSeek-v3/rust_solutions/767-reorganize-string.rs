use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn reorganize_string(s: String) -> String {
        let mut counts = vec![0; 26];
        for c in s.chars() {
            let idx = c as usize - 'a' as usize;
            counts[idx] += 1;
        }

        let mut heap = BinaryHeap::new();
        for i in 0..26 {
            if counts[i] > 0 {
                heap.push((counts[i], (i as u8 + b'a') as char));
            }
        }

        let mut result = String::new();
        while heap.len() >= 2 {
            let (count1, char1) = heap.pop().unwrap();
            let (count2, char2) = heap.pop().unwrap();

            result.push(char1);
            result.push(char2);

            if count1 > 1 {
                heap.push((count1 - 1, char1));
            }
            if count2 > 1 {
                heap.push((count2 - 1, char2));
            }
        }

        if !heap.is_empty() {
            let (count, char) = heap.pop().unwrap();
            if count > 1 {
                return String::new();
            }
            result.push(char);
        }

        result
    }
}