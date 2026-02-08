use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn diameter_of_binary_tree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>) -> (i32, i32) {
            match node {
                None => (0, 0),
                Some(n) => {
                    let left = dfs(&n.borrow().left);
                    let right = dfs(&n.borrow().right);
                    let height = 1 + std::cmp::max(left.0, right.0);
                    let diameter = std::cmp::max(left.0 + right.0, std::cmp::max(left.1, right.1));
                    (height, diameter)
                }
            }
        }

        dfs(&root).1
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