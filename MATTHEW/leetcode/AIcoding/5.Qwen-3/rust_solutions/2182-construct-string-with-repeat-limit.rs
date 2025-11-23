impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn repeat_limited_string(s: String, limit: i32) -> String {
        let mut freq = std::collections::HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut max_heap = BinaryHeap::new();
        for (c, count) in &freq {
            max_heap.push(Reverse((*count, *c)));
        }

        let mut result = String::new();

        while let Some(Reverse(mut count_char)) = max_heap.pop() {
            let (mut count, c) = count_char;

            if result.is_empty() || result.chars().last() != Some(c) {
                let take = std::cmp::min(limit, count);
                result.push_str(&c.to_string().repeat(take as usize));
                count -= take;
                if count > 0 {
                    max_heap.push(Reverse((count, c)));
                }
            } else {
                if let Some(Reverse(mut next_count_char)) = max_heap.pop() {
                    let (next_count, next_c) = next_count_char;
                    if next_count == 0 {
                        break;
                    }
                    result.push(next_c);
                    let next_count = next_count - 1;
                    if next_count > 0 {
                        max_heap.push(Reverse((next_count, next_c)));
                    }
                    max_heap.push(Reverse((count, c)));
                } else {
                    break;
                }
            }
        }

        result
    }
}
}