impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
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

use std::collections::{HashMap, VecDeque};

pub fn distance_k(root: Option<Box<TreeNode>>, target: i32, k: i32) -> Vec<i32> {
    let mut parent_map = HashMap::new();
    let mut queue = VecDeque::new();

    if let Some(ref root) = root {
        queue.push_back(root);
    }

    while let Some(node) = queue.pop_front() {
        if let Some(left) = &node.left {
            parent_map.insert(left.val, node.val);
            queue.push_back(left);
        }
        if let Some(right) = &node.right {
            parent_map.insert(right.val, node.val);
            queue.push_back(right);
        }
    }

    let mut result = Vec::new();
    let mut visited = std::collections::HashSet::new();
    let mut queue = VecDeque::new();

    queue.push_back(target);
    visited.insert(target);

    while let Some(current) = queue.pop_front() {
        if k == 0 {
            result.push(current);
            break;
        }

        if let Some(&parent) = parent_map.get(&current) {
            if !visited.contains(&parent) {
                visited.insert(parent);
                queue.push_back(parent);
            }
        }

        if let Some(ref node) = root {
            if let Some(left) = &node.left {
                if left.val == current {
                    if let Some(left) = &left.left {
                        if !visited.contains(&left.val) {
                            visited.insert(left.val);
                            queue.push_back(left.val);
                        }
                    }
                    if let Some(right) = &left.right {
                        if !visited.contains(&right.val) {
                            visited.insert(right.val);
                            queue.push_back(right.val);
                        }
                    }
                }
            }
            if let Some(right) = &node.right {
                if right.val == current {
                    if let Some(left) = &right.left {
                        if !visited.contains(&left.val) {
                            visited.insert(left.val);
                            queue.push_back(left.val);
                        }
                    }
                    if let Some(right) = &right.right {
                        if !visited.contains(&right.val) {
                            visited.insert(right.val);
                            queue.push_back(right.val);
                        }
                    }
                }
            }
        }

        k -= 1;
    }

    result
}
}