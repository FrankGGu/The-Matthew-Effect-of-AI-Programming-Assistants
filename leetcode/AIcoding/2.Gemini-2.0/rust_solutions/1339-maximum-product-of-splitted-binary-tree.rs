use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn max_product(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, sum: &mut i64) -> i64 {
            if let Some(n) = node {
                let left = dfs(&n.borrow().left, sum);
                let right = dfs(&n.borrow().right, sum);
                let current = left + right + n.borrow().val as i64;
                *sum = (*sum).max(current);
                current
            } else {
                0
            }
        }

        fn find_max_product(node: &Option<Rc<RefCell<TreeNode>>>, total_sum: i64, max_product: &mut i64) -> i64 {
            if let Some(n) = node {
                let left = find_max_product(&n.borrow().left, total_sum, max_product);
                let right = find_max_product(&n.borrow().right, total_sum, max_product);
                let current_sum = left + right + n.borrow().val as i64;
                *max_product = (*max_product).max(current_sum * (total_sum - current_sum));
                current_sum
            } else {
                0
            }
        }

        let mut total_sum: i64 = 0;
        dfs(&root, &mut total_sum);

        let mut max_product: i64 = 0;
        find_max_product(&root, total_sum, &mut max_product);

        (max_product % 1000000007) as i32
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