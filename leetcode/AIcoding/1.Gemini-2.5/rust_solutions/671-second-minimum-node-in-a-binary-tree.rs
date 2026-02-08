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
    pub fn find_second_minimum_value(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut min1 = -1;
        let mut min2 = -1; // Sentinel value to indicate no second minimum found yet

        if let Some(node_rc) = root {
            min1 = node_rc.borrow().val;
            Self::dfs(&node_rc, min1, &mut min2);
        }

        min2
    }

    fn dfs(node_rc: &Rc<RefCell<TreeNode>>, min1: i32, min2: &mut i32) {
        let node = node_rc.borrow();

        // Optimization: If current node's value is already greater than or equal to min2 (and min2 is found),
        // then any values in this subtree will be >= current.val, so they won't be a smaller second minimum.
        if *min2 != -1 && node.val >= *min2 {
            return;
        }

        // If current node's value is strictly greater than min1, it's a candidate for min2.
        if node.val > min1 {
            *min2 = node.val;
        }

        // Recurse on children
        if let Some(left_rc) = &node.left {
            Self::dfs(left_rc, min1, min2);
        }
        if let Some(right_rc) = &node.right {
            Self::dfs(right_rc, min1, min2);
        }
    }
}