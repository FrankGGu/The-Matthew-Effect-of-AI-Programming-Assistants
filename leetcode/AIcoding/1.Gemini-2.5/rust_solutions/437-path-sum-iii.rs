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
        let mut prefix_sum_counts: HashMap<i32, i32> = HashMap::new();
        prefix_sum_counts.insert(0, 1);

        Self::dfs(root, 0, target_sum, &mut prefix_sum_counts)
    }

    fn dfs(
        node: Option<Rc<RefCell<TreeNode>>>,
        current_sum: i32,
        target_sum: i32,
        prefix_sum_counts: &mut HashMap<i32, i32>,
    ) -> i32 {
        if node.is_none() {
            return 0;
        }

        let node_rc = node.unwrap();
        let node_ref = node_rc.borrow();

        let new_current_sum = current_sum + node_ref.val;
        let mut count = 0;

        if let Some(&freq) = prefix_sum_counts.get(&(new_current_sum - target_sum)) {
            count += freq;
        }

        *prefix_sum_counts.entry(new_current_sum).or_insert(0) += 1;

        count += Self::dfs(node_ref.left.clone(), new_current_sum, target_sum, prefix_sum_counts);
        count += Self::dfs(node_ref.right.clone(), new_current_sum, target_sum, prefix_sum_counts);

        *prefix_sum_counts.get_mut(&new_current_sum).unwrap() -= 1;
        if *prefix_sum_counts.get(&new_current_sum).unwrap() == 0 {
            prefix_sum_counts.remove(&new_current_sum);
        }

        count
    }
}