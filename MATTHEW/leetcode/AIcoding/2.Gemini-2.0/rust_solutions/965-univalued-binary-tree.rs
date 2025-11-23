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
    pub fn is_unival_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return true;
        }

        let root_val = root.as_ref().unwrap().borrow().val;

        fn check(node: Option<Rc<RefCell<TreeNode>>>, val: i32) -> bool {
            if node.is_none() {
                return true;
            }

            let node_ref = node.as_ref().unwrap().borrow();
            if node_ref.val != val {
                return false;
            }

            check(node_ref.left.clone(), val) && check(node_ref.right.clone(), val)
        }

        check(root, root_val)
    }
}

struct Solution;