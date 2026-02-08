use std::collections::VecDeque;

#[derive(Node)]
struct Node {
    val: i32,
    children: Vec<Node>,
}

pub fn postorder(root: Option<Box<Node>>) -> Vec<i32> {
    let mut result = Vec::new();
    let mut stack = VecDeque::new();

    if let Some(node) = root {
        stack.push_back(node);
    }

    while let Some(node) = stack.pop_back() {
        let mut node = node;
        result.push(node.val);
        for child in node.children {
            stack.push_back(child);
        }
    }

    result.reverse();
    result
}