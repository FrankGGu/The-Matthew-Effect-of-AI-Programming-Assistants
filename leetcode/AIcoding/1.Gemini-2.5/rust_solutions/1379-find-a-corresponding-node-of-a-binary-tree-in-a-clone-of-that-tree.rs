use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn get_target_copy(original: Option<Rc<RefCell<TreeNode>>>, cloned: Option<Rc<RefCell<TreeNode>>>, target: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if original.is_none() {
            return None;
        }

        if let Some(original_node_rc) = &original {
            if let Some(target_rc) = &target {
                if Rc::ptr_eq(original_node_rc, target_rc) {
                    return cloned;
                }
            }
        }

        let original_left = original.as_ref().and_then(|node_rc| node_rc.borrow().left.clone());
        let cloned_left = cloned.as_ref().and_then(|node_rc| node_rc.borrow().left.clone());

        if let Some(result) = Self::get_target_copy(original_left, cloned_left, target.clone()) {
            return Some(result);
        }

        let original_right = original.as_ref().and_then(|node_rc| node_rc.borrow().right.clone());
        let cloned_right = cloned.as_ref().and_then(|node_rc| node_rc.borrow().right.clone());

        Self::get_target_copy(original_right, cloned_right, target.clone())
    }
}