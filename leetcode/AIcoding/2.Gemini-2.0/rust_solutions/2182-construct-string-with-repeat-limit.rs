use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn repeat_limited_string(s: String, repeat_limit: i32) -> String {
        let mut counts = [0; 26];
        for &b in s.as_bytes() {
            counts[(b - b'a') as usize] += 1;
        }

        let mut heap: BinaryHeap<(i32, usize)> = BinaryHeap::new();
        for i in 0..26 {
            if counts[i] > 0 {
                heap.push((counts[i], i));
            }
        }

        let mut result = String::new();
        while !heap.is_empty() {
            let (count1, char1_idx) = heap.pop().unwrap();
            let char1 = (b'a' + char1_idx as u8) as char;
            let repeat_count = std::cmp::min(count1, repeat_limit);
            for _ in 0..repeat_count {
                result.push(char1);
            }

            if count1 > repeat_limit {
                if !heap.is_empty() {
                    let (count2, char2_idx) = heap.pop().unwrap();
                    let char2 = (b'a' + char2_idx as u8) as char;
                    result.push(char2);
                    heap.push((count2 - 1, char2_idx));
                } else {
                    break;
                }
                heap.push((count1 - repeat_count, char1_idx));
            }
        }

        result
    }
}