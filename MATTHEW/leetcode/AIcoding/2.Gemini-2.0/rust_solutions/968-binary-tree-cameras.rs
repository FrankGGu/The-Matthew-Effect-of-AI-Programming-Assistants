use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn min_camera_cover(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, count: &mut i32) -> i32 {
            if node.is_none() {
                return 1;
            }

            let node = node.as_ref().unwrap();
            let left = dfs(&node.borrow().left, count);
            let right = dfs(&node.borrow().right, count);

            if left == 0 || right == 0 {
                *count += 1;
                return 2;
            }

            if left == 2 || right == 2 {
                return 1;
            }

            0
        }

        let mut count = 0;
        if dfs(&root, &mut count) == 0 {
            count += 1;
        }

        count
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