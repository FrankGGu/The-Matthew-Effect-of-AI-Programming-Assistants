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
    fn dfs(node_opt: Option<Rc<RefCell<TreeNode>>>, x: i32, left_x_size: &mut i32, right_x_size: &mut i32) -> i32 {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            let mut size = 1;

            let left_subtree_size = Self::dfs(node.left.clone(), x, left_x_size, right_x_size);
            let right_subtree_size = Self::dfs(node.right.clone(), x, left_x_size, right_x_size);

            size += left_subtree_size;
            size += right_subtree_size;

            if node.val == x {
                *left_x_size = left_subtree_size;
                *right_x_size = right_subtree_size;
            }

            size
        } else {
            0
        }
    }

    pub fn btree_coloring_game(root: Option<Rc<RefCell<TreeNode>>>, n: i32, x: i32) -> bool {
        let mut left_x_size = 0;
        let mut right_x_size = 0;

        Self::dfs(root, x, &mut left_x_size, &mut right_x_size);

        let parent_x_size = n - 1 - left_x_size - right_x_size;

        if left_x_size > n / 2 || right_x_size > n / 2 || parent_x_size > n / 2 {
            false
        } else {
            true
        }
    }
}