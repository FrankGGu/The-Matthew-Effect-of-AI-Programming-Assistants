use std::collections::BinaryHeap;

impl Solution {
    pub fn longest_happy_string(a: i32, b: i32, c: i32) -> String {
        let mut heap: BinaryHeap<(i32, char)> = BinaryHeap::new();
        if a > 0 {
            heap.push((a, 'a'));
        }
        if b > 0 {
            heap.push((b, 'b'));
        }
        if c > 0 {
            heap.push((c, 'c'));
        }

        let mut result = String::new();

        while !heap.is_empty() {
            let mut first_char_info = heap.pop().unwrap();

            let len = result.len();
            let can_append_first = if len < 2 {
                true
            } else {
                let bytes = result.as_bytes();
                let last_two_chars_are_same = bytes[len - 1] == first_char_info.1 as u8 &&
                                               bytes[len - 2] == first_char_info.1 as u8;
                !last_two_chars_are_same
            };

            if can_append_first {
                result.push(first_char_info.1);
                first_char_info.0 -= 1;
                if first_char_info.0 > 0 {
                    heap.push(first_char_info);
                }
            } else {
                if heap.is_empty() {
                    break;
                }
                let mut second_char_info = heap.pop().unwrap();

                result.push(second_char_info.1);
                second_char_info.0 -= 1;

                heap.push(first_char_info);

                if second_char_info.0 > 0 {
                    heap.push(second_char_info);
                }
            }
        }

        result
    }
}