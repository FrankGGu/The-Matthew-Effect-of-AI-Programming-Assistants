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
    pub fn rob(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn helper(node: &Option<Rc<RefCell<TreeNode>>>) -> (i32, i32) {
            match node {
                None => (0, 0),
                Some(n) => {
                    let left = helper(&n.borrow().left);
                    let right = helper(&n.borrow().right);
                    let rob = n.borrow().val + left.1 + right.1;
                    let no_rob = left.0.max(left.1) + right.0.max(right.1);
                    (rob, no_rob)
                }
            }
        }

        let (rob, no_rob) = helper(&root);
        rob.max(no_rob)
    }
}

struct Solution;