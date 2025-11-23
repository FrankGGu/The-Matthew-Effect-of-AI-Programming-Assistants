use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn btree_game_winning_move(root: Option<Rc<RefCell<TreeNode>>>, n: i32, x: i32) -> bool {
        fn count_nodes(node: &Option<Rc<RefCell<TreeNode>>>, x: i32, x_found: &mut bool, left_count: &mut i32, right_count: &mut i32) -> i32 {
            if let Some(node_rc) = node {
                let node_ref = node_rc.borrow();
                let left = count_nodes(&node_ref.left, x, x_found, left_count, right_count);
                let right = count_nodes(&node_ref.right, x, x_found, left_count, right_count);
                if node_ref.val == x {
                    *x_found = true;
                    *left_count = left;
                    *right_count = right;
                    return 1;
                }
                return left + right + 1;
            }
            0
        }

        let mut x_found = false;
        let mut left_count = 0;
        let mut right_count = 0;

        count_nodes(&root, x, &mut x_found, &mut left_count, &mut right_count);

        let parent_count = n - left_count - right_count - 1;

        return left_count > n / 2 || right_count > n / 2 || parent_count > n / 2;
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