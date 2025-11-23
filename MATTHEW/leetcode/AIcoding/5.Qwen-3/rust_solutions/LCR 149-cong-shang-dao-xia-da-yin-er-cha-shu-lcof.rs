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

use std::cell::RefCell;
use std::rc::Rc;

pub fn decorate_record_i(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    if root.is_none() {
        return result;
    }

    let mut queue = std::collections::VecDeque::new();
    queue.push_back(root);

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut level = Vec::new();

        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                let node_ref = node.borrow();
                level.push(node_ref.val);

                if let Some(left) = &node_ref.left {
                    queue.push_back(Some(left.clone()));
                }
                if let Some(right) = &node_ref.right {
                    queue.push_back(Some(right.clone()));
                }
            }
        }

        result.push(level);
    }

    result
}
}