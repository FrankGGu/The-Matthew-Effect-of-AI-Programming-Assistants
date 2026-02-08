use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

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
    pub fn kth_largest_level_sum(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i64 {
        let mut level_sums: Vec<i64> = Vec::new();
        let mut q: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();

        if let Some(node) = root {
            q.push_back(node);
        }

        while !q.is_empty() {
            let level_size = q.len();
            let mut current_level_sum: i64 = 0;

            for _ in 0..level_size {
                if let Some(node_rc) = q.pop_front() {
                    let node = node_rc.borrow();
                    current_level_sum += node.val as i64;

                    if let Some(left_child) = node.left.clone() {
                        q.push_back(left_child);
                    }
                    if let Some(right_child) = node.right.clone() {
                        q.push_back(right_child);
                    }
                }
            }
            level_sums.push(current_level_sum);
        }

        level_sums.sort_unstable_by(|a, b| b.cmp(a)); // Sort in descending order
        level_sums[(k - 1) as usize]
    }
}