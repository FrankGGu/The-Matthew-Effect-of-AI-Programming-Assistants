use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn trim_bst(root: Option<Rc<RefCell<TreeNode>>>, low: i32, high: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node_rc) = root {
            let mut node = node_rc.borrow_mut();

            if node.val < low {
                return Self::trim_bst(node.right.take(), low, high);
            } else if node.val > high {
                return Self::trim_bst(node.left.take(), low, high);
            } else {
                node.left = Self::trim_bst(node.left.take(), low, high);
                node.right = Self::trim_bst(node.right.take(), low, high);
                drop(node); 
                return Some(node_rc);
            }
        }
        None
    }
}