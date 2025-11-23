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
    pub fn check_equal_tree_partition(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        let mut all_subtree_sums: Vec<i64> = Vec::new();

        fn dfs_collect_sums(node: Option<Rc<RefCell<TreeNode>>>, sums: &mut Vec<i64>) -> i64 {
            if let Some(node_rc) = node {
                let node_ref = node_rc.borrow();
                let left_sum = dfs_collect_sums(node_ref.left.clone(), sums);
                let right_sum = dfs_collect_sums(node_ref.right.clone(), sums);
                let current_node_sum = node_ref.val as i64 + left_sum + right_sum;
                sums.push(current_node_sum);
                current_node_sum
            } else {
                0
            }
        }

        let total_sum = dfs_collect_sums(root.clone(), &mut all_subtree_sums);

        if total_sum % 3 != 0 {
            return false;
        }

        let target_sum = total_sum / 3;

        if let Some(idx) = all_subtree_sums.iter().rposition(|&s| s == total_sum) {
            all_subtree_sums.remove(idx);
        }

        let mut count_target_sums = 0;
        for &sum in &all_subtree_sums {
            if sum == target_sum {
                count_target_sums += 1;
            }
        }

        count_target_sums >= 2
    }
}