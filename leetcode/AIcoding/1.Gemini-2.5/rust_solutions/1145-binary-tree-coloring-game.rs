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
    pub fn bst_coloring_game(root: Option<Rc<RefCell<TreeNode>>>, n: i32, x: i32) -> bool {
        let mut left_size = 0;
        let mut right_size = 0;

        fn dfs(node_opt: Option<Rc<RefCell<TreeNode>>>, x_val: i32, left_size_ref: &mut i32, right_size_ref: &mut i32) -> i32 {
            if let Some(node_rc) = node_opt {
                let node = node_rc.borrow();
                let l_count = dfs(node.left.clone(), x_val, left_size_ref, right_size_ref);
                let r_count = dfs(node.right.clone(), x_val, left_size_ref, right_size_ref);

                if node.val == x_val {
                    *left_size_ref = l_count;
                    *right_size_ref = r_count;
                }
                return 1 + l_count + r_count;
            }
            0
        }

        dfs(root, x, &mut left_size, &mut right_size);

        let parent_side_size = n - 1 - left_size - right_size;

        let max_p2_region = left_size.max(right_size).max(parent_side_size);

        n - max_p2_region > max_p2_region
    }
}