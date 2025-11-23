impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<TreeNode>,
    pub right: Option<TreeNode>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

use std::cmp::Ordering;
use std::collections::VecDeque;

pub fn smallest_from_leaf(root: Option<Box<TreeNode>>) -> String {
    let mut result = String::new();
    let mut queue = VecDeque::new();
    if let Some(node) = root {
        queue.push_back((node, String::new()));
    }

    while let Some((node, mut path)) = queue.pop_front() {
        let c = (b'a' + (node.val as u8)) as char;
        path.push(c);

        if node.left.is_none() && node.right.is_none() {
            if result.is_empty() || path.cmp(&result) == Ordering::Less {
                result = path;
            }
        } else {
            if let Some(left) = node.left {
                queue.push_back((left, path.clone()));
            }
            if let Some(right) = node.right {
                queue.push_back((right, path));
            }
        }
    }

    result
}
}