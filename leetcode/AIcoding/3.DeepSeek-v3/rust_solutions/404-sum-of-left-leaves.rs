use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sum_of_left_leaves(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn helper(node: &Option<Rc<RefCell<TreeNode>>>, is_left: bool) -> i32 {
            if let Some(n) = node {
                let n = n.borrow();
                if n.left.is_none() && n.right.is_none() && is_left {
                    return n.val;
                }
                return helper(&n.left, true) + helper(&n.right, false);
            }
            0
        }
        helper(&root, false)
    }
}