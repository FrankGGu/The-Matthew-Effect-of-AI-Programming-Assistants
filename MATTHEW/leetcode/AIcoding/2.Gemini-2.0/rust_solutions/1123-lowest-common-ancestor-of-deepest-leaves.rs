use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn lca_deepest_leaves(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>) -> (Option<Rc<RefCell<TreeNode>>>, i32) {
            match node {
                None => (None, 0),
                Some(n) => {
                    let left = dfs(n.borrow().left.clone());
                    let right = dfs(n.borrow().right.clone());

                    if left.1 > right.1 {
                        (left.0, left.1 + 1)
                    } else if left.1 < right.1 {
                        (right.0, right.1 + 1)
                    } else {
                        (Some(n.clone()), left.1 + 1)
                    }
                }
            }
        }

        dfs(root).0
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