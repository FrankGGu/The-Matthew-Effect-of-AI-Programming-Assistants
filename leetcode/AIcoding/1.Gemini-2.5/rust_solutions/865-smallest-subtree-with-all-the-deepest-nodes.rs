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
    pub fn subtree_with_all_deepest(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::dfs(root).1
    }

    // Helper function returns (depth, node_that_is_LCA_of_deepest_nodes_in_this_subtree)
    fn dfs(node_opt: Option<Rc<RefCell<TreeNode>>>) -> (i32, Option<Rc<RefCell<TreeNode>>>) {
        if node_opt.is_none() {
            return (0, None);
        }

        let node_rc = node_opt.as_ref().unwrap();
        let node = node_rc.borrow();

        let (left_depth, left_lca) = Self::dfs(node.left.clone());
        let (right_depth, right_lca) = Self::dfs(node.right.clone());

        if left_depth == right_depth {
            (left_depth + 1, node_opt.clone())
        } else if left_depth > right_depth {
            (left_depth + 1, left_lca)
        } else { // right_depth > left_depth
            (right_depth + 1, right_lca)
        }
    }
}