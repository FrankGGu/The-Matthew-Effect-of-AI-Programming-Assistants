use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

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
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> i32 {
        let mut total_paths = 0;
        let mut prefix_sum_counts: HashMap<i32, i32> = HashMap::new();
        // Initialize with 0 sum having one count. This handles paths that start from the root
        // and sum up to target_sum.
        prefix_sum_counts.insert(0, 1);

        Self::dfs(root, 0, target_sum, &mut prefix_sum_counts, &mut total_paths);

        total_paths
    }

    fn dfs(
        node_opt: Option<Rc<RefCell<TreeNode>>>,
        mut current_sum: i32,
        target_sum: i32,
        prefix_sum_counts: &mut HashMap<i32, i32>,
        total_paths: &mut i32,
    ) {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();

            current_sum += node.val;

            // Check if a prefix sum exists such that (current_sum - prefix_sum) == target_sum.
            // This means prefix_sum == current_sum - target_sum.
            // If such a prefix_sum exists, it implies a path from that prefix_sum's node
            // to the current node sums to target_sum.
            if let Some(count) = prefix_sum_counts.get(&(current_sum - target_sum)) {
                *total_paths += count;
            }

            // Increment the count for the current_sum in the map.
            // This current_sum is now a valid prefix sum for its children.
            *prefix_sum_counts.entry(current_sum).or_insert(0) += 1;

            // Recurse on children
            Self::dfs(node.left.clone(), current_sum, target_sum, prefix_sum_counts, total_paths);
            Self::dfs(node.right.clone(), current_sum, target_sum, prefix_sum_counts, total_paths);

            // Backtrack: Decrement the count for the current_sum.
            // When returning from a node, its current_sum is no longer a valid prefix
            // for its parent's other children or its parent's ancestors.
            *prefix_sum_counts.entry(current_sum).or_insert(0) -= 1;
        }
    }
}