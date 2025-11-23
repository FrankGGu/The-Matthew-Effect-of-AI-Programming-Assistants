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
    pub fn deepest_leaves_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_depth = 0;
        let mut sum = 0;

        Self::dfs(root, 0, &mut max_depth, &mut sum);

        sum
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, current_depth: i32, max_depth: &mut i32, sum: &mut i32) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();

            if current_depth > *max_depth {
                *max_depth = current_depth;
                *sum = 0; 
            }

            if current_depth == *max_depth {
                if n.left.is_none() && n.right.is_none() {
                    *sum += n.val;
                }
            }

            Self::dfs(n.left.clone(), current_depth + 1, max_depth, sum);
            Self::dfs(n.right.clone(), current_depth + 1, max_depth, sum);
        }
    }
}