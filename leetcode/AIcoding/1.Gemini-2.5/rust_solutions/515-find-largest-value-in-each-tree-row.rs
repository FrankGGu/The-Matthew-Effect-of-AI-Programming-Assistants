use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

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

struct Solution;

impl Solution {
    pub fn largest_values(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut queue = VecDeque::new();

        if let Some(node) = root {
            queue.push_back(node);
        } else {
            return result;
        }

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut max_val_in_row = i32::MIN;

            for _ in 0..level_size {
                if let Some(node_rc) = queue.pop_front() {
                    let node = node_rc.borrow();
                    max_val_in_row = max_val_in_row.max(node.val);

                    if let Some(left_child) = node.left.clone() {
                        queue.push_back(left_child);
                    }
                    if let Some(right_child) = node.right.clone() {
                        queue.push_back(right_child);
                    }
                }
            }
            result.push(max_val_in_row);
        }

        result
    }
}