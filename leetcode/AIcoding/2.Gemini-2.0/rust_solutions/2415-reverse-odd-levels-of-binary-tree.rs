use std::cell::RefCell;
use std::rc::Rc;

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
      right: None,
    }
  }
}

impl Solution {
    pub fn reverse_odd_levels(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        fn dfs(node1: Option<Rc<RefCell<TreeNode>>>, node2: Option<Rc<RefCell<TreeNode>>>, level: i32) {
            if node1.is_none() || node2.is_none() {
                return;
            }

            if level % 2 != 0 {
                let val1 = node1.as_ref().unwrap().borrow().val;
                let val2 = node2.as_ref().unwrap().borrow().val;
                node1.as_ref().unwrap().borrow_mut().val = val2;
                node2.as_ref().unwrap().borrow_mut().val = val1;
            }

            dfs(node1.as_ref().unwrap().borrow().left.clone(), node2.as_ref().unwrap().borrow().right.clone(), level + 1);
            dfs(node1.as_ref().unwrap().borrow().right.clone(), node2.as_ref().unwrap().borrow().left.clone(), level + 1);
        }

        if root.is_none() {
            return None;
        }

        dfs(root.clone(), root.clone(), 0);
        root
    }
}

struct Solution;