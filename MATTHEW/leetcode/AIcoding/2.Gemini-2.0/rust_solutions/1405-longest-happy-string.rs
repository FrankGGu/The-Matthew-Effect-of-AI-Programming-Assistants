use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn longest_happy_string(a: i32, b: i32, c: i32) -> String {
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

        let mut result = String::new();

        while !heap.is_empty() {
            let (count1, char1) = heap.pop().unwrap();

            if result.len() >= 2 && result.chars().nth(result.len() - 1).unwrap() == char1 && result.chars().nth(result.len() - 2).unwrap() == char1 {
                if heap.is_empty() {
                    break;
                }

                let (count2, char2) = heap.pop().unwrap();
                result.push(char2);
                if count2 > 1 {
                    heap.push((count2 - 1, char2));
                }
                heap.push((count1, char1));
            } else {
                result.push(char1);
                if count1 > 1 {
                    heap.push((count1 - 1, char1));
                }
            }
        }

        result
    }
}