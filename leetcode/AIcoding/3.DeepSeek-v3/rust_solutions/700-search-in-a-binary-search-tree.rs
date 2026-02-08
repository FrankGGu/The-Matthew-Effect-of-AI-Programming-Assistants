use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn search_bst(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        let mut current = root;
        while let Some(node) = current {
            let node_val = node.borrow().val;
            if node_val == val {
                return Some(node);
            } else if node_val > val {
                current = node.borrow().left.clone();
            } else {
                current = node.borrow().right.clone();
            }
        }
        None
    }
}