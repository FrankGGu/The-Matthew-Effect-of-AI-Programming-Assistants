use std::collections::BinaryHeap;

impl Solution {
    pub fn longest_diverse_string(a: i32, b: i32, c: i32) -> String {
        let mut heap = BinaryHeap::new();
        if a > 0 {
            heap.push((a, 'a'));
        }
        if b > 0 {
            heap.push((b, 'b'));
        }
        if c > 0 {
            heap.push((c, 'c'));
        }

        let mut res = String::new();
        let mut prev_char = None;
        let mut prev_count = 0;

        while let Some((count, ch)) = heap.pop() {
            if prev_count > 0 && prev_count < count {
                heap.push((prev_count, prev_char.unwrap()));
                prev_char = None;
                prev_count = 0;
                continue;
            }

            if res.len() >= 2 && res.chars().last().unwrap() == ch && res.chars().nth(res.len() - 2).unwrap() == ch {
                prev_char = Some(ch);
                prev_count = count;
                continue;
            }

            res.push(ch);
            if count > 1 {
                heap.push((count - 1, ch));
            }
            prev_char = None;
            prev_count = 0;
        }

        res
    }
}