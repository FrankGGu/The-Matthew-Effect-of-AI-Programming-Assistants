use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn longest_univalue_path(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, max_len: &mut i32) -> i32 {
            if let Some(n) = node {
                let left = dfs(&n.borrow().left, max_len);
                let right = dfs(&n.borrow().right, max_len);

                let mut left_path = 0;
                let mut right_path = 0;

                if let Some(l) = &n.borrow().left {
                    if n.borrow().val == l.borrow().val {
                        left_path = left + 1;
                    }
                }

                if let Some(r) = &n.borrow().right {
                    if n.borrow().val == r.borrow().val {
                        right_path = right + 1;
                    }
                }

                *max_len = (*max_len).max(left_path + right_path);
                return left_path.max(right_path);
            }
            0
        }

        let mut max_len = 0;
        dfs(&root, &mut max_len);
        max_len
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