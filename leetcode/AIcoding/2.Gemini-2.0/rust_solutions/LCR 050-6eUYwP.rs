use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, prefix_sums: &mut std::collections::HashMap<i32, i32>, current_sum: i32, target_sum: i32) -> i32 {
            if let Some(node_rc) = node {
                let node_ref = node_rc.borrow();
                let current_sum = current_sum + node_ref.val;
                let mut count = prefix_sums.get(&(current_sum - target_sum)).cloned().unwrap_or(0);

                *prefix_sums.entry(current_sum).or_insert(0) += 1;

                count += dfs(&node_ref.left, prefix_sums, current_sum, target_sum);
                count += dfs(&node_ref.right, prefix_sums, current_sum, target_sum);

                *prefix_sums.get_mut(&current_sum).unwrap() -= 1;

                count
            } else {
                0
            }
        }

        let mut prefix_sums: std::collections::HashMap<i32, i32> = std::collections::HashMap::new();
        prefix_sums.insert(0, 1);

        dfs(&root, &mut prefix_sums, 0, target_sum)
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