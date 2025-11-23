impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn delete_greatest_value(mut head: Option<Box<ListNode>>) -> i32 {
        let mut max_values = Vec::new();

        while let Some(node) = head {
            let mut current = &node;
            let mut max_val = current.val;

            while let Some(next) = &current.next {
                max_val = max_val.max(next.val);
                current = next;
            }

            max_values.push(max_val);
            head = node.next;
        }

        max_values.into_iter().max().unwrap()
    }
}
}