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
    pub fn reverse_odd_levels(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let root_rc = root.as_ref().unwrap().clone();
        let root_borrow = root_rc.borrow();

        Self::dfs_helper(&root_borrow.left, &root_borrow.right, 1);

        root
    }

    fn dfs_helper(node1_opt: &Option<Rc<RefCell<TreeNode>>>, node2_opt: &Option<Rc<RefCell<TreeNode>>>, level: i32) {
        if node1_opt.is_none() || node2_opt.is_none() {
            return;
        }

        if level % 2 == 1 {
            let node1_rc = node1_opt.as_ref().unwrap().clone();
            let node2_rc = node2_opt.as_ref().unwrap().clone();
            let mut node1_mut = node1_rc.borrow_mut();
            let mut node2_mut = node2_rc.borrow_mut();
            std::mem::swap(&mut node1_mut.val, &mut node2_mut.val);
        }

        let node1_borrow = node1_opt.as_ref().unwrap().borrow();
        let node2_borrow = node2_opt.as_ref().unwrap().borrow();

        Self::dfs_helper(&node1_borrow.left, &node2_borrow.right, level + 1);
        Self::dfs_helper(&node1_borrow.right, &node2_borrow.left, level + 1);
    }
}