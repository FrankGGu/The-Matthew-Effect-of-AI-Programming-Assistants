use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn check_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        let root_node = root.as_ref().unwrap().borrow();
        let left_val = root_node.left.as_ref().unwrap().borrow().val;
        let right_val = root_node.right.as_ref().unwrap().borrow().val;
        root_node.val == left_val + right_val
    }
}