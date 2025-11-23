impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn sum_of_left_leaves(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn helper(node: Option<Rc<RefCell<TreeNode>>>, is_left: bool) -> i32 {
        if let Some(n) = node {
            let n = n.borrow();
            if n.left.is_none() && n.right.is_none() {
                if is_left {
                    return n.val;
                }
                return 0;
            }
            return helper(n.left.clone(), true) + helper(n.right.clone(), false);
        }
        0
    }

    helper(root, false)
}
}