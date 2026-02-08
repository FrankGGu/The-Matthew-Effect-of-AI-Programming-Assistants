use std::rc::Rc;
use std::cell::RefCell;

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
    pub fn rob(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>) -> (i32, i32) {
            if let Some(n_rc) = node {
                let n = n_rc.borrow();

                let (left_taken, left_skipped) = dfs(n.left.clone());
                let (right_taken, right_skipped) = dfs(n.right.clone());

                let current_taken = n.val + left_skipped + right_skipped;
                let current_skipped = left_taken.max(left_skipped) + right_taken.max(right_skipped);

                (current_taken, current_skipped)
            } else {
                (0, 0)
            }
        }

        let (taken_root, skipped_root) = dfs(root);
        taken_root.max(skipped_root)
    }
}