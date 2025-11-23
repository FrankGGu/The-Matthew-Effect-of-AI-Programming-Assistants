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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_subtree(root: Option<Rc<RefCell<TreeNode>>>, sub_root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if sub_root.is_none() {
            return true;
        }
        if root.is_none() {
            return false;
        }

        let root_borrow = root.as_ref().unwrap().borrow();
        if Self::is_same_tree(root.clone(), sub_root.clone()) {
            return true;
        }

        Self::is_subtree(root_borrow.left.clone(), sub_root.clone()) ||
        Self::is_subtree(root_borrow.right.clone(), sub_root.clone())
    }

    fn is_same_tree(p: Option<Rc<RefCell<TreeNode>>>, q: Option<Rc<RefCell<TreeNode>>>) -> bool {
        match (p, q) {
            (None, None) => true,
            (Some(p_node), Some(q_node)) => {
                let p_borrow = p_node.borrow();
                let q_borrow = q_node.borrow();

                p_borrow.val == q_borrow.val &&
                Self::is_same_tree(p_borrow.left.clone(), q_borrow.left.clone()) &&
                Self::is_same_tree(p_borrow.right.clone(), q_borrow.right.clone())
            }
            _ => false,
        }
    }
}

struct Solution;