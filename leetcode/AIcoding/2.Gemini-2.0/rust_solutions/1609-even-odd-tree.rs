use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn is_even_odd_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return true;
        }

        let mut queue = std::collections::VecDeque::new();
        queue.push_back(root.unwrap());

        let mut level = 0;

        while !queue.is_empty() {
            let len = queue.len();
            let mut prev = if level % 2 == 0 { i32::MIN } else { i32::MAX };

            for _ in 0..len {
                let node = queue.pop_front().unwrap();
                let val = node.borrow().val;

                if level % 2 == 0 {
                    if val % 2 == 0 || val <= prev {
                        return false;
                    }
                } else {
                    if val % 2 != 0 || val >= prev {
                        return false;
                    }
                }

                prev = val;

                if let Some(left) = &node.borrow().left {
                    queue.push_back(Rc::clone(left));
                }
                if let Some(right) = &node.borrow().right {
                    queue.push_back(Rc::clone(right));
                }
            }

            level += 1;
        }

        true
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