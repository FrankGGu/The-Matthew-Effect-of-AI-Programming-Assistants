use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn get_target_copy(
        original: Option<Rc<RefCell<TreeNode>>>,
        cloned: Option<Rc<RefCell<TreeNode>>>,
        target: Option<Rc<RefCell<TreeNode>>>,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if original.is_none() || cloned.is_none() {
            return None;
        }
        let original_node = original.unwrap();
        let cloned_node = cloned.unwrap();
        if Rc::ptr_eq(&original_node, &target.unwrap()) {
            return Some(cloned_node);
        }
        let left = Self::get_target_copy(
            original_node.borrow().left.clone(),
            cloned_node.borrow().left.clone(),
            target.clone(),
        );
        if left.is_some() {
            return left;
        }
        Self::get_target_copy(
            original_node.borrow().right.clone(),
            cloned_node.borrow().right.clone(),
            target,
        )
    }
}