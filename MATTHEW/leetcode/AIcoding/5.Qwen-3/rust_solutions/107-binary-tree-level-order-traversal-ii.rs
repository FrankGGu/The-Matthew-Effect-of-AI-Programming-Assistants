impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn level_order_bottom(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    if root.is_none() {
        return result;
    }

    let mut queue = vec![root.unwrap()];
    while !queue.is_empty() {
        let level_size = queue.len();
        let mut level = Vec::new();
        for _ in 0..level_size {
            let node = queue.remove(0);
            let node_ref = node.borrow();
            level.push(node_ref.val);
            if let Some(left) = &node_ref.left {
                queue.push(left.clone());
            }
            if let Some(right) = &node_ref.right {
                queue.push(right.clone());
            }
        }
        result.push(level);
    }

    result.reverse();
    result
}
}