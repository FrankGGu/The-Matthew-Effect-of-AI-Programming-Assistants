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
    pub fn max_level_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if root.is_none() {
            return 0;
        }

        let mut max_sum = i32::MIN;
        let mut max_level = 0;
        let mut current_level = 1;

        let mut q: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        if let Some(node) = root {
            q.push_back(node);
        }

        while !q.is_empty() {
            let level_size = q.len();
            let mut current_level_sum = 0;

            for _ in 0..level_size {
                if let Some(node_rc) = q.pop_front() {
                    let node = node_rc.borrow();
                    current_level_sum += node.val;

                    if let Some(left_child) = &node.left {
                        q.push_back(Rc::clone(left_child));
                    }
                    if let Some(right_child) = &node.right {
                        q.push_back(Rc::clone(right_child));
                    }
                }
            }

            if current_level_sum > max_sum {
                max_sum = current_level_sum;
                max_level = current_level;
            }
            current_level += 1;
        }

        max_level
    }
}