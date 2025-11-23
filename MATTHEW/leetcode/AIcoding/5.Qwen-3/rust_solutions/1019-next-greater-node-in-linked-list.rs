impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn next_greater_node(head: Option<Box<ListNode>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut stack = VecDeque::new();
        let mut index = 0;

        let mut current = head;

        while let Some(node) = current {
            while let Some((i, val)) = stack.back() {
                if *val < node.val {
                    stack.pop_back();
                    result[*i] = node.val;
                } else {
                    break;
                }
            }

            stack.push_back((index, node.val));
            result.push(0);
            index += 1;

            current = node.next;
        }

        result
    }
}
}