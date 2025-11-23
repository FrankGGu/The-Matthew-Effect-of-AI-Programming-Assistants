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
    pub fn sum_of_left_leaves(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        Self::dfs(&root, false)
    }

    fn dfs(node_opt: &Option<Rc<RefCell<TreeNode>>>, is_left_child: bool) -> i32 {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            let mut current_sum = 0;

            if is_left_child && node.left.is_none() && node.right.is_none() {
                current_sum += node.val;
            }

            current_sum += Self::dfs(&node.left, true);
            current_sum += Self::dfs(&node.right, false);

            current_sum
        } else {
            0
        }
    }
}