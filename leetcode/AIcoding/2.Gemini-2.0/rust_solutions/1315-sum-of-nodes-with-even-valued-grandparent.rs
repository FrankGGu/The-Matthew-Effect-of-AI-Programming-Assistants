use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sum_even_grandparent(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, parent_val: i32, grandparent_val: i32) -> i32 {
            if let Some(n) = node {
                let node_ref = n.borrow();
                let current_val = node_ref.val;
                let mut sum = 0;

                if grandparent_val % 2 == 0 {
                    sum += current_val;
                }

                sum += dfs(node_ref.left.clone(), current_val, parent_val);
                sum += dfs(node_ref.right.clone(), current_val, parent_val);

                sum
            } else {
                0
            }
        }

        dfs(root, 1, 1)
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