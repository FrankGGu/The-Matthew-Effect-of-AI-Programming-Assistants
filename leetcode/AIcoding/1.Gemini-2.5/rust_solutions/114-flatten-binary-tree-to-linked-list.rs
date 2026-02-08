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
    pub fn flatten(root: &mut Option<Rc<RefCell<TreeNode>>>) {
        if root.is_none() {
            return;
        }

        let node_rc = root.as_ref().unwrap();
        let mut node_borrow = node_rc.borrow_mut();

        Solution::flatten(&mut node_borrow.left);
        Solution::flatten(&mut node_borrow.right);

        if node_borrow.left.is_some() {
            let original_right_subtree = node_borrow.right.take();

            node_borrow.right = node_borrow.left.take();

            let mut current_tail_opt = node_borrow.right.clone();
            while let Some(tail_rc) = current_tail_opt {
                let tail_node_borrow = tail_rc.borrow();
                if tail_node_borrow.right.is_none() {
                    drop(tail_node_borrow);
                    tail_rc.borrow_mut().right = original_right_subtree;
                    break;
                }
                let next_rc = tail_node_borrow.right.clone();
                drop(tail_node_borrow);
                current_tail_opt = next_rc;
            }
        }
    }
}