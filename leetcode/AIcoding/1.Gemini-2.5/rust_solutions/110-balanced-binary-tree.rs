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
    pub fn is_balanced(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        Self::check_height(&root) != -1
    }

    fn check_height(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
        match node {
            None => 0,
            Some(rc_node) => {
                let node_ref = rc_node.borrow();

                let left_height = Self::check_height(&node_ref.left);
                if left_height == -1 {
                    return -1;
                }

                let right_height = Self::check_height(&node_ref.right);
                if right_height == -1 {
                    return -1;
                }

                if (left_height - right_height).abs() > 1 {
                    -1
                } else {
                    1 + left_height.max(right_height)
                }
            }
        }
    }
}