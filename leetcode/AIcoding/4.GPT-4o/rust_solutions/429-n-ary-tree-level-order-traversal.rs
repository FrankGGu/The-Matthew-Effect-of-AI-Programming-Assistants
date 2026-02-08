use std::collections::VecDeque;

#[derive(Debug)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Node>,
}

impl Node {
    fn new(val: i32) -> Self {
        Node {
            val,
            children: Vec::new(),
        }
    }
}

pub fn level_order(root: Option<Box<Node>>) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    if root.is_none() {
        return result;
    }

    let mut queue = VecDeque::new();
    queue.push_back(root);

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut level = Vec::new();

        for _ in 0..level_size {
            if let Some(Some(node)) = queue.pop_front() {
                level.push(node.val);
                for child in node.children {
                    queue.push_back(Some(Box::new(child)));
                }
            }
        }

        result.push(level);
    }

    result
}