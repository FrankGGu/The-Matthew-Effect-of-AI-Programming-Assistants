impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn longest_univalue_path(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    let mut max_length = 0;
    longest_univalue_path_helper(root, &mut max_length);
    max_length
}

fn longest_univalue_path_helper(
    root: Option<Rc<RefCell<TreeNode>>>,
    max_length: &mut i32,
) -> i32 {
    if let Some(node) = root {
        let node_ref = node.borrow();
        let left_val = node_ref.left.as_ref().map(|n| n.borrow().val).unwrap_or(i32::MIN);
        let right_val = node_ref.right.as_ref().map(|n| n.borrow().val).unwrap_or(i32::MIN);

        let left_length = if left_val == node_ref.val {
            longest_univalue_path_helper(node_ref.left.clone(), max_length)
        } else {
            0
        };

        let right_length = if right_val == node_ref.val {
            longest_univalue_path_helper(node_ref.right.clone(), max_length)
        } else {
            0
        };

        *max_length = std::cmp::max(*max_length, left_length + right_length);

        std::cmp::max(left_length, right_length) + 1
    } else {
        0
    }
}
}