impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

pub fn subtree_inversion_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn invert(node: &Rc<RefCell<TreeNode>>) {
        let mut n = node.borrow_mut();
        std::mem::swap(&mut n.left, &mut n.right);
        if let Some(left) = &n.left {
            invert(left);
        }
        if let Some(right) = &n.right {
            invert(right);
        }
    }

    fn sum(node: &Rc<RefCell<TreeNode>>) -> i32 {
        let n = node.borrow();
        let left_sum = if let Some(left) = &n.left { sum(left) } else { 0 };
        let right_sum = if let Some(right) = &n.right { sum(right) } else { 0 };
        n.val + left_sum + right_sum
    }

    if let Some(root) = root {
        invert(&root);
        sum(&root)
    } else {
        0
    }
}
}