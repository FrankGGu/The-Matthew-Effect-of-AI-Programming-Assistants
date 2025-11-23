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
    pub fn kth_largest_perfect_subtree_size(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i32 {
        let mut perfect_subtree_sizes: Vec<i32> = Vec::new();

        fn dfs(
            node_opt: Option<Rc<RefCell<TreeNode>>>,
            sizes: &mut Vec<i32>,
        ) -> (bool, i32, i32) {
            match node_opt {
                None => (true, -1, 0),
                Some(node_rc) => {
                    let node = node_rc.borrow();

                    let (left_is_perfect, left_height, left_size) = dfs(node.left.clone(), sizes);
                    let (right_is_perfect, right_height, right_size) = dfs(node.right.clone(), sizes);

                    let current_is_perfect =
                        left_is_perfect && right_is_perfect && (left_height == right_height);

                    let current_height = std::cmp::max(left_height, right_height) + 1;

                    let current_size = left_size + right_size + 1;

                    if current_is_perfect {
                        sizes.push(current_size);
                    }

                    (current_is_perfect, current_height, current_size)
                }
            }
        }

        dfs(root, &mut perfect_subtree_sizes);

        perfect_subtree_sizes.sort_unstable_by(|a, b| b.cmp(a));

        perfect_subtree_sizes[(k - 1) as usize]
    }
}