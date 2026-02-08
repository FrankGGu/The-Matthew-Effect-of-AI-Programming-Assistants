use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn find_bottom_left_value(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut queue = std::collections::VecDeque::new();
        if let Some(root_node) = root {
            queue.push_back(root_node);
        }

        let mut leftmost = 0;

        while !queue.is_empty() {
            let level_size = queue.len();
            leftmost = queue[0].borrow().val;

            for _ in 0..level_size {
                if let Some(node) = queue.pop_front() {
                    if let Some(left) = &node.borrow().left {
                        queue.push_back(Rc::clone(left));
                    }
                    if let Some(right) = &node.borrow().right {
                        queue.push_back(Rc::clone(right));
                    }
                }
            }
        }

        leftmost
    }
}

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