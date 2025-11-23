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
    pub fn closest_nodes(root: Option<Rc<RefCell<TreeNode>>>, queries: Vec<i32>) -> Vec<Vec<i32>> {
        let mut sorted_values = Vec::new();
        Self::inorder_traversal(root, &mut sorted_values);

        let mut results = Vec::new();
        for q in queries {
            let mut min_val = -1;
            let mut max_val = -1;

            let idx_min = sorted_values.partition_point(|&x| x < q);
            if idx_min < sorted_values.len() {
                min_val = sorted_values[idx_min];
            }

            let idx_max = sorted_values.partition_point(|&x| x <= q);
            if idx_max > 0 {
                max_val = sorted_values[idx_max - 1];
            }

            results.push(vec![max_val, min_val]);
        }

        results
    }

    fn inorder_traversal(node: Option<Rc<RefCell<TreeNode>>>, values: &mut Vec<i32>) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            Self::inorder_traversal(n.left.clone(), values);
            values.push(n.val);
            Self::inorder_traversal(n.right.clone(), values);
        }
    }
}