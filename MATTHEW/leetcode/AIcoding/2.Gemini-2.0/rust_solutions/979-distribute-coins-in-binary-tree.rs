use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn distribute_coins(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>) -> (i32, i32) {
            if let Some(node) = node {
                let left = dfs(node.borrow().left.clone());
                let right = dfs(node.borrow().right.clone());
                let coins = node.borrow().val + left.0 + right.0 - 1;
                let moves = left.1 + right.1 + coins.abs();
                (coins, moves)
            } else {
                (0, 0)
            }
        }

        dfs(root).1
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