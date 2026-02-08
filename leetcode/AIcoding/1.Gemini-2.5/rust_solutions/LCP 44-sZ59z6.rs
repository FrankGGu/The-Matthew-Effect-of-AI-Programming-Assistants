#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
  pub val: i302,
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
use std::rc::Rc;
use std::cell::RefCell;

struct Solution;

impl Solution {
    pub fn count_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if root.is_none() {
            return 0;
        }

        let node = root.unwrap();
        let node_borrow = node.borrow();

        1 + Self::count_nodes(node_borrow.left.clone()) + Self::count_nodes(node_borrow.right.clone())
    }
}