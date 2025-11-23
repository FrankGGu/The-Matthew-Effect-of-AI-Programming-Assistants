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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn kth_largest_level_sum(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i64 {
        let mut level_sums: Vec<i64> = Vec::new();
        let mut queue: VecDeque<Option<Rc<RefCell<TreeNode>>>> = VecDeque::new();
        queue.push_back(root);

        while !queue.is_empty() {
            let mut level_sum: i64 = 0;
            let mut level_size = queue.len();

            for _ in 0..level_size {
                if let Some(node) = queue.pop_front().unwrap() {
                    let node_ref = node.borrow();
                    level_sum += node_ref.val as i64;

                    if let Some(left) = &node_ref.left {
                        queue.push_back(Some(Rc::clone(left)));
                    }
                    if let Some(right) = &node_ref.right {
                        queue.push_back(Some(Rc::clone(right)));
                    }
                }
            }

            level_sums.push(level_sum);
        }

        level_sums.sort_unstable_by(|a, b| b.cmp(a));

        if level_sums.len() < k as usize {
            return -1;
        }

        level_sums[k as usize - 1]
    }
}

struct Solution;