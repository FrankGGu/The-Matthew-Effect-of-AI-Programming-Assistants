use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Node>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node {
            val,
            children: Vec::new(),
        }
    }
}

impl Solution {
    pub fn level_order(root: Option<Node>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        if root.is_none() {
            return result;
        }
        let mut queue = VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut current_level = Vec::with_capacity(level_size);

            for _ in 0..level_size {
                let node = queue.pop_front().unwrap();
                current_level.push(node.val);
                for child in node.children {
                    queue.push_back(child);
                }
            }
            result.push(current_level);
        }
        result
    }
}