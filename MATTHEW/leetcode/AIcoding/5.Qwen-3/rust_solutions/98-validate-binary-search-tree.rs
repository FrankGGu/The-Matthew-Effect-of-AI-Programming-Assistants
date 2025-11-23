impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn is_valid_bst(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
    fn helper(node: Option<Rc<RefCell<TreeNode>>>, lower: i64, upper: i64) -> bool {
        match node {
            None => true,
            Some(n) => {
                let node = n.borrow();
                let val = node.val as i64;
                if val <= lower || val >= upper {
                    return false;
                }
                helper(node.left, lower, val) && helper(node.right, val, upper)
            }
        }
    }

    helper(root, i64::MIN, i64::MAX)
}
}