use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn invert_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        match root {
            Some(node) => {
                let left = node.borrow_mut().left.take();
                let right = node.borrow_mut().right.take();
                node.borrow_mut().left = Solution::invert_tree(Some(Rc::clone(&Rc::new(RefCell::new(TreeNode {
                    val: 0,
                    left: left,
                    right: None
                }))))?.borrow().left.take());
                node.borrow_mut().right = Solution::invert_tree(Some(Rc::clone(&Rc::new(RefCell::new(TreeNode {
                    val: 0,
                    left: right,
                    right: None
                }))))?.borrow().left.take());
                Some(node)
            }
            None => None,
        }
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