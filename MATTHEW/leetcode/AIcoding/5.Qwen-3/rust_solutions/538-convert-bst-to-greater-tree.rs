impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

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

pub fn convert_bst(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
    let mut sum = 0;
    convert_bst_helper(root, &mut sum);
    root
}

fn convert_bst_helper(
    root: Option<Rc<RefCell<TreeNode>>>,
    sum: &mut i32,
) -> Option<Rc<RefCell<TreeNode>>> {
    if let Some(node) = root {
        let right = convert_bst_helper(node.borrow_mut().right.take(), sum);
        *sum += node.borrow().val;
        node.borrow_mut().val = *sum;
        let left = convert_bst_helper(node.borrow_mut().left.take(), sum);
        node.borrow_mut().right = right;
        node.borrow_mut().left = left;
        Some(node)
    } else {
        None
    }
}
}