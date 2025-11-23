use std::collections::VecDeque;

#[derive(Clone, Copy)]
struct Node {
    val: i32,
    left: Option<Box<Node>>,
    right: Option<Box<Node>>,
    next: Option<Box<Node>>,
}

impl Node {
    fn new(val: i32) -> Option<Box<Node>> {
        Some(Box::new(Node {
            val,
            left: None,
            right: None,
            next: None,
        }))
    }
}

pub fn connect(root: Option<Box<Node>>) -> Option<Box<Node>> {
    if root.is_none() {
        return root;
    }

    let mut queue = VecDeque::new();
    queue.push_back(root);

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut prev: Option<Box<Node>> = None;

        for _ in 0..level_size {
            let node = queue.pop_front().unwrap();
            if let Some(node_ref) = node.as_ref() {
                if let Some(prev_ref) = prev.as_ref() {
                    prev_ref.next = Some(node.clone());
                }
                prev = Some(node.clone());
                if let Some(left) = node_ref.left.as_ref() {
                    queue.push_back(Some(left.clone()));
                }
                if let Some(right) = node_ref.right.as_ref() {
                    queue.push_back(Some(right.clone()));
                }
            }
        }
    }

    root
}