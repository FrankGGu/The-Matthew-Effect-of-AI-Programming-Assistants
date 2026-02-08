use std::cell::RefCell;
use std::collections::VecDeque;
use std::rc::Rc;

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
      right: None,
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
        let mut level: i32 = 0;

        while !queue.is_empty() {
            let mut level_values: Vec<i32> = Vec::new();
            let level_size = queue.len();

            for _ in 0..level_size {
                if let Some(node) = queue.pop_front() {
                    level_values.push(node.borrow().val);

                    if let Some(left) = &node.borrow().left {
                        queue.push_back(Rc::clone(left));
                    }
                    if let Some(right) = &node.borrow().right {
                        queue.push_back(Rc::clone(right));
                    }
                }
            }

            if level % 2 == 1 {
                level_values.reverse();
            }
            result.push(level_values);
            level += 1;
        }

        result
    }
}

struct Solution;