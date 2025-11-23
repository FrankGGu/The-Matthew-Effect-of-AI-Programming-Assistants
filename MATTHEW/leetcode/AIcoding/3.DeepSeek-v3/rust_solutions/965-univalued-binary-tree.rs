use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn is_unival_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if let Some(node) = root {
            let node = node.borrow();
            let val = node.val;
            Self::helper(&node.left, val) && Self::helper(&node.right, val)
        } else {
            true
        }
    }

    fn helper(root: &Option<Rc<RefCell<TreeNode>>>, val: i32) -> bool {
        if let Some(node) = root {
            let node = node.borrow();
            node.val == val && Self::helper(&node.left, val) && Self::helper(&node.right, val)
        } else {
            true
        }
    }
}