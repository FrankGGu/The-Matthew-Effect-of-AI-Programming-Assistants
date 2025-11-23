use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn prune_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node) = root {
            let left = Self::prune_tree(node.borrow_mut().left.take());
            let right = Self::prune_tree(node.borrow_mut().right.take());
            if left.is_none() && right.is_none() && node.borrow().val == 0 {
                None
            } else {
                node.borrow_mut().left = left;
                node.borrow_mut().right = right;
                Some(node)
            }
        } else {
            None
        }
    }
}