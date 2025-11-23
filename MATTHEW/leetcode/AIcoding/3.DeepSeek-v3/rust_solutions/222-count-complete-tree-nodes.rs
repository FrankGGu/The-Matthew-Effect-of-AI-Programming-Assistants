use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn count_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if let Some(node) = root {
            let left_depth = Self::get_depth(node.borrow().left.clone());
            let right_depth = Self::get_depth(node.borrow().right.clone());
            if left_depth == right_depth {
                (1 << left_depth) + Self::count_nodes(node.borrow().right.clone())
            } else {
                (1 << right_depth) + Self::count_nodes(node.borrow().left.clone())
            }
        } else {
            0
        }
    }

    fn get_depth(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if let Some(node) = root {
            1 + Self::get_depth(node.borrow().left.clone())
        } else {
            0
        }
    }
}