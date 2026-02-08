use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn trim_bst(root: Option<Rc<RefCell<TreeNode>>>, low: i32, high: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node) = root {
            let mut node_ref = node.borrow_mut();
            if node_ref.val < low {
                return Self::trim_bst(node_ref.right.take(), low, high);
            } else if node_ref.val > high {
                return Self::trim_bst(node_ref.left.take(), low, high);
            } else {
                node_ref.left = Self::trim_bst(node_ref.left.take(), low, high);
                node_ref.right = Self::trim_bst(node_ref.right.take(), low, high);
                return Some(node.clone());
            }
        }
        None
    }
}