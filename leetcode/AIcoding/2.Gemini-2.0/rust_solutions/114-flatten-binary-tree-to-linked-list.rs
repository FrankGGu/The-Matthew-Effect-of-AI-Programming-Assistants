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
    pub fn flatten(root: &mut Option<Rc<RefCell<TreeNode>>>) {
        if root.is_none() {
            return;
        }

        let mut current = root.clone();

        while let Some(node_rc) = current {
            let mut node = node_rc.borrow_mut();

            if node.left.is_some() {
                let mut rightmost = node.left.clone();
                while let Some(rightmost_node_rc) = rightmost.clone() {
                    let rightmost_node = rightmost_node_rc.borrow();
                    if rightmost_node.right.is_none() {
                        break;
                    }
                    rightmost = rightmost_node.right.clone();
                }

                if let Some(rightmost_node_rc) = rightmost {
                    let mut rightmost_node = rightmost_node_rc.borrow_mut();
                    rightmost_node.right = node.right.take();
                }

                node.right = node.left.take();
            }

            current = node.right.clone();
        }
    }
}

struct Solution;