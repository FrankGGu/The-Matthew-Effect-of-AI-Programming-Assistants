impl Solution {

use std::cmp::Ordering;
use std::collections::BinaryHeap;

#[derive(PartialEq, Eq)]
struct Element {
    value: i32,
    list_idx: usize,
    element_idx: usize,
}

impl PartialOrd for Element {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Element {
    fn cmp(&self, other: &Self) -> Ordering {
        self.value.cmp(&other.value)
    }
}

impl Solution {
    pub fn smallest_range(mut lists: Vec<Vec<i32>>) -> Vec<i32> {
        let mut min_heap = BinaryHeap::new();
        let mut max_val = i32::MIN;

        for (i, list) in lists.iter_mut().enumerate() {
            if !list.is_empty() {
                min_heap.push(Element {
                    value: list[0],
                    list_idx: i,
                    element_idx: 0,
                });
                max_val = std::cmp::max(max_val, list[0]);
            }
        }

        let mut result = vec![i32::MIN, i32::MAX];
        let mut current_min = min_heap.peek().unwrap().value;

        while let Some(current) = min_heap.pop() {
            let current_range = max_val - current.value;
            if current_range < (result[1] - result[0]) {
                result = vec![current.value, max_val];
            }

            let list_idx = current.list_idx;
            let element_idx = current.element_idx;

            if element_idx + 1 < lists[list_idx].len() {
                let next_value = lists[list_idx][element_idx + 1];
                min_heap.push(Element {
                    value: next_value,
                    list_idx,
                    element_idx: element_idx + 1,
                });
                max_val = std::cmp::max(max_val, next_value);
            } else {
                break;
            }

            current_min = min_heap.peek().unwrap().value;
        }

        result
    }
}
}