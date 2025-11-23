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

use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn lowest_common_ancestor(root: Option<Rc<RefCell<TreeNode>>>, p: Option<Rc<RefCell<TreeNode>>>, q: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, p: Option<Rc<RefCell<TreeNode>>>, q: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
            if node.is_none() {
                return None;
            }

            let node_ref = node.as_ref().unwrap().borrow();

            if Rc::ptr_eq(node.as_ref().unwrap(), p.as_ref().unwrap()) || Rc::ptr_eq(node.as_ref().unwrap(), q.as_ref().unwrap()) {
                return node.clone();
            }

            let left = dfs(node_ref.left.clone(), p.clone(), q.clone());
            let right = dfs(node_ref.right.clone(), p.clone(), q.clone());

            if left.is_some() && right.is_some() {
                return node.clone();
            } else if left.is_some() {
                return left;
            } else {
                return right;
            }
        }

        dfs(root, p, q)
    }
}