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
    pub fn diameter_of_binary_tree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_diameter = 0;
        Self::dfs_height(root, &mut max_diameter);
        max_diameter
    }

    fn dfs_height(node: Option<Rc<RefCell<TreeNode>>>, max_diameter: &mut i32) -> i32 {
        if let Some(node_rc) = node {
            let node_ref = node_rc.borrow();
            let left_height = Self::dfs_height(node_ref.left.clone(), max_diameter);
            let right_height = Self::dfs_height(node_ref.right.clone(), max_diameter);

            *max_diameter = (*max_diameter).max(left_height + right_height);

            1 + left_height.max(right_height)
        } else {
            0
        }
    }
}