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
    pub fn decorate_record_i(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut current_level_nodes: Vec<i32> = Vec::new();

            for _ in 0..level_size {
                let node_rc = queue.pop_front().unwrap();
                let node_ref = node_rc.borrow();
                current_level_nodes.push(node_ref.val);

                if let Some(left_child) = &node_ref.left {
                    queue.push_back(Rc::clone(left_child));
                }
                if let Some(right_child) = &node_ref.right {
                    queue.push_back(Rc::clone(right_child));
                }
            }
            result.push(current_level_nodes);
        }

        result
    }
}