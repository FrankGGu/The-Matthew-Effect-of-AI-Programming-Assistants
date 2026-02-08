use serde::{Serialize, Deserialize};
use std::collections::VecDeque;

#[derive(Serialize, Deserialize, PartialEq, Eq, Debug)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub struct Codec;

impl Codec {
    pub fn serialize(root: Option<Box<TreeNode>>) -> String {
        let mut result = String::new();
        let mut queue = VecDeque::new();
        queue.push_back(root);

        while !queue.is_empty() {
            if let Some(node) = queue.pop_front() {
                if let Some(n) = node {
                    result.push_str(&format!("{},", n.val));
                    queue.push_back(n.left);
                    queue.push_back(n.right);
                } else {
                    result.push_str("null,");
                }
            }
        }
        result.pop(); // Remove the trailing comma
        result
    }

    pub fn deserialize(data: String) -> Option<Box<TreeNode>> {
        if data.is_empty() {
            return None;
        }

        let nodes: Vec<Option<Box<TreeNode>>> = data
            .split(',')
            .map(|s| {
                if s == "null" {
                    None
                } else {
                    Some(Box::new(TreeNode {
                        val: s.parse().unwrap(),
                        left: None,
                        right: None,
                    }))
                }
            })
            .collect();

        let mut queue = VecDeque::from(nodes);
        let root = queue.pop_front().unwrap();
        let mut current = Some(root.clone());

        for i in 0..nodes.len() {
            if let Some(node) = current {
                if let Some(left) = queue.pop_front() {
                    node.left = left;
                }
                if let Some(right) = queue.pop_front() {
                    node.right = right;
                }
                current = Some(node);
            }
        }

        root
    }
}