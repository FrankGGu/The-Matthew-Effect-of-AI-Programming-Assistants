#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
  pub val: i32,
  pub left: Option<Rc<RefCell<TreeNode>>>,
  pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
  #[inline]
  pub fn new(val: i32) -> Self {
    TreeNode {
      val,
      left: None,
      right: None
    }
  }
}

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn get_target_copy(original: Option<Rc<RefCell<TreeNode>>>, cloned: Option<Rc<RefCell<TreeNode>>>, target: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if original.is_none() || cloned.is_none() || target.is_none() {
            return None;
        }

        let mut original_queue = vec![original.clone()];
        let mut cloned_queue = vec![cloned.clone()];

        while !original_queue.is_empty() {
            let original_node = original_queue.remove(0).unwrap();
            let cloned_node = cloned_queue.remove(0).unwrap();

            if Rc::ptr_eq(&original_node, &target.clone().unwrap()) {
                return Some(cloned_node);
            }

            let original_left = original_node.borrow().left.clone();
            let original_right = original_node.borrow().right.clone();

            let cloned_left = cloned_node.borrow().left.clone();
            let cloned_right = cloned_node.borrow().right.clone();

            if original_left.is_some() {
                original_queue.push(original_left.clone());
                cloned_queue.push(cloned_left.clone());
            }

            if original_right.is_some() {
                original_queue.push(original_right.clone());
                cloned_queue.push(cloned_right.clone());
            }
        }

        None
    }
}

struct Solution;