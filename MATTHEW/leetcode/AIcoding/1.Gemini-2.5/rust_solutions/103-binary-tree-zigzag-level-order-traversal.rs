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

impl Solution {
    pub fn zigzag_level_order(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        queue.push_back(root.unwrap());
        let mut left_to_right = true;

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut current_level_values: Vec<i32> = Vec::with_capacity(level_size);

            for _ in 0..level_size {
                let node_rc = queue.pop_front().unwrap();
                let node = node_rc.borrow();
                current_level_values.push(node.val);

                if let Some(left_child) = node.left.clone() {
                    queue.push_back(left_child);
                }
                if let Some(right_child) = node.right.clone() {
                    queue.push_back(right_child);
                }
            }

            if !left_to_right {
                current_level_values.reverse();
            }
            result.push(current_level_values);
            left_to_right = !left_to_right;
        }

        result
    }
}