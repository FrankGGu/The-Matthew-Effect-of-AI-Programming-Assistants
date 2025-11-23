use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_ancestor_diff(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, min_val: i32, max_val: i32) -> i32 {
            match node {
                None => max_val - min_val,
                Some(n) => {
                    let node_borrow = n.borrow();
                    let val = node_borrow.val;
                    let new_min = min_val.min(val);
                    let new_max = max_val.max(val);

                    let left_diff = dfs(node_borrow.left.clone(), new_min, new_max);
                    let right_diff = dfs(node_borrow.right.clone(), new_min, new_max);

                    left_diff.max(right_diff)
                }
            }
        }

        if root.is_none() {
            return 0;
        }

        let root_borrow = root.clone().unwrap().borrow();
        dfs(root.clone(), root_borrow.val, root_borrow.val)
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