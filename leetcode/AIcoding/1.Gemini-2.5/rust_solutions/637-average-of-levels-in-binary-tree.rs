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
    pub fn average_of_levels(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<f64> {
        let mut averages = Vec::new();
        if root.is_none() {
            return averages;
        }

        let mut queue: VecDeque<Option<Rc<RefCell<TreeNode>>>> = VecDeque::new();
        queue.push_back(root);

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut level_sum: f64 = 0.0;
            let mut level_count: i32 = 0;

            for _ in 0..level_size {
                if let Some(Some(node_rc)) = queue.pop_front() {
                    let node = node_rc.borrow();
                    level_sum += node.val as f64;
                    level_count += 1;

                    if node.left.is_some() {
                        queue.push_back(node.left.clone());
                    }
                    if node.right.is_some() {
                        queue.push_back(node.right.clone());
                    }
                }
            }
            if level_count > 0 {
                averages.push(level_sum / level_count as f64);
            }
        }
        averages
    }
}