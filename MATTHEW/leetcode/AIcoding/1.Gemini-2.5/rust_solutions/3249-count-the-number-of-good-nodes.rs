use std::rc::Rc;
use std::cell::RefCell;
use std::cmp::max;

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
    pub fn good_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        Self::dfs(root, i32::MIN)
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_val_so_far: i32) -> i32 {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            let mut count = 0;
            if n.val >= max_val_so_far {
                count += 1;
            }
            let new_max_val = max(max_val_so_far, n.val);
            count += Self::dfs(n.left.clone(), new_max_val);
            count += Self::dfs(n.right.clone(), new_max_val);
            count
        } else {
            0
        }
    }
}