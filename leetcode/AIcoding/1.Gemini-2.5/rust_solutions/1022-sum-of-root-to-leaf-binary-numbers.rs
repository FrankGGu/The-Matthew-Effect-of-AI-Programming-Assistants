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
    pub fn sum_root_to_leaf(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut total_sum = 0;
        Self::dfs(root, 0, &mut total_sum);
        total_sum
    }

    fn dfs(node_opt: Option<Rc<RefCell<TreeNode>>>, current_num: i32, total_sum: &mut i32) {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            let new_current_num = (current_num << 1) | node.val;

            if node.left.is_none() && node.right.is_none() {
                *total_sum += new_current_num;
            } else {
                Self::dfs(node.left.clone(), new_current_num, total_sum);
                Self::dfs(node.right.clone(), new_current_num, total_sum);
            }
        }
    }
}