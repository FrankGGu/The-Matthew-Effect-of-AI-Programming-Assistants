use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn minimize_string_value(s: String) -> String {
        let mut counts: Vec<i32> = vec![0; 26];
        let mut q_count: i32 = 0;

        for c in s.chars() {
            if c == '?' {
                q_count += 1;
            } else {
                counts[(c as u8 - b'a') as usize] += 1;
            }
        }

        let mut pq: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();
        for i in 0..26 {
            pq.push(Reverse((counts[i], i)));
        }

        let mut assigned_chars: Vec<char> = Vec::new();

        for _ in 0..q_count {
            if let Some(Reverse((count, char_idx))) = pq.pop() {
                assigned_chars.push((b'a' + char_idx as u8) as char);
                pq.push(Reverse((count + 1, char_idx)));
            }
        }

        assigned_chars.sort_unstable();

        let mut result_chars: Vec<char> = Vec::new();
        let mut assigned_iter = assigned_chars.into_iter();

        for c in s.chars() {
            if c == '?' {
                if let Some(assigned_c) = assigned_iter.next() {
                    result_chars.push(assigned_c);
                }
            } else {
                result_chars.push(c);
            }
        }

        result_chars.into_iter().collect()
    }
}