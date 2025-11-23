impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn minimize_string_value(a: String) -> String {
        let mut a = a.chars().collect::<Vec<char>>();
        let mut heap = BinaryHeap::new();

        for i in 0..a.len() {
            if i > 0 && a[i] < a[i - 1] {
                heap.push(Reverse(i));
            }
        }

        while let Some(Reverse(i)) = heap.pop() {
            if i == 0 || a[i] >= a[i - 1] {
                continue;
            }
            a.swap(i, i - 1);
            if i > 1 && a[i] < a[i - 1] {
                heap.push(Reverse(i));
            }
            if i < a.len() - 1 && a[i] < a[i + 1] {
                heap.push(Reverse(i + 1));
            }
        }

        a.into_iter().collect()
    }
}

struct Solution {}
}