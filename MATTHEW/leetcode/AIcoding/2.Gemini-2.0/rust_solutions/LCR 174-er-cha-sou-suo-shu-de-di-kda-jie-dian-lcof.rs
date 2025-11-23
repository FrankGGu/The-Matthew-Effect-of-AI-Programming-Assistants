use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn search_bst(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        match root {
            Some(node) => {
                let val_node = node.borrow().val;
                if val == val_node {
                    return Some(node);
                } else if val < val_node {
                    return Self::search_bst(node.borrow().left.clone(), val);
                } else {
                    return Self::search_bst(node.borrow().right.clone(), val);
                }
            }
            None => None,
        }
    }
}