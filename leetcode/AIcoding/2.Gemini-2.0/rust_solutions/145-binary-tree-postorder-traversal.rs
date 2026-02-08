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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn postorder_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut stack = Vec::new();
        let mut last_visited = None;

        let mut current = root;

        while !stack.is_empty() || current.is_some() {
            while let Some(node) = current {
                stack.push(node.clone());
                current = node.borrow().left.clone();
            }

            let top = stack.last().unwrap().clone();

            if top.borrow().right.is_none() || last_visited == top.borrow().right {
                result.push(top.borrow().val);
                last_visited = Some(top.clone());
                stack.pop();
                current = None;
            } else {
                current = top.borrow().right.clone();
            }
        }

        result
    }
}

struct Solution;