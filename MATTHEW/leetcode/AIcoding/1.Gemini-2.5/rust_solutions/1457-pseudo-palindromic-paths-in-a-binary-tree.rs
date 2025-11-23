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

impl Solution {
    pub fn pseudo_palindromic_paths(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        Self::dfs(root, 0)
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, mut mask: i32) -> i32 {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            mask ^= (1 << n.val);

            if n.left.is_none() && n.right.is_none() {
                if (mask & (mask - 1)) == 0 {
                    return 1;
                } else {
                    return 0;
                }
            }

            let mut count = 0;
            count += Self::dfs(n.left.clone(), mask);
            count += Self::dfs(n.right.clone(), mask);
            return count;
        }
        0
    }
}