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

struct Solution {
    count: i32,
}

impl Solution {
    pub fn average_of_subtree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut sol = Solution { count: 0 };
        sol.dfs(root);
        sol.count
    }

    // Returns a tuple (sum_of_nodes, number_of_nodes) for the subtree rooted at `node`.
    fn dfs(&mut self, node: Option<Rc<RefCell<TreeNode>>>) -> (i32, i32) {
        if node.is_none() {
            return (0, 0);
        }

        let node_rc = node.unwrap();
        let node_ref = node_rc.borrow();

        let (left_sum, left_count) = self.dfs(node_ref.left.clone());
        let (right_sum, right_count) = self.dfs(node_ref.right.clone());

        let current_sum = node_ref.val + left_sum + right_sum;
        let current_total_nodes = 1 + left_count + right_count;

        if node_ref.val == current_sum / current_total_nodes {
            self.count += 1;
        }

        (current_sum, current_total_nodes)
    }
}