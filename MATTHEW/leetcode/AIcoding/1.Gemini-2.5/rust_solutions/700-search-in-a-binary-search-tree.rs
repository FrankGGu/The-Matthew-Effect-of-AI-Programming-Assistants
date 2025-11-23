use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn search_bst(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node_rc) = root {
            let node = node_rc.borrow();
            if val == node.val {
                Some(node_rc)
            } else if val < node.val {
                Self::search_bst(node.left.clone(), val)
            } else {
                Self::search_bst(node.right.clone(), val)
            }
        } else {
            None
        }
    }
}