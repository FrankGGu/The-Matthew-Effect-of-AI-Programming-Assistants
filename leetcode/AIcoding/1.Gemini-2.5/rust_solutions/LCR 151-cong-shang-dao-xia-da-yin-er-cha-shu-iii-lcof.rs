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
    pub fn zigzag_level_order(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();

        if let Some(node) = root {
            queue.push_back(node);
        } else {
            return result;
        }

        let mut level_num = 0;

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut current_level_nodes: Vec<i32> = Vec::with_capacity(level_size);

            for _ in 0..level_size {
                if let Some(node_rc) = queue.pop_front() {
                    let node = node_rc.borrow();
                    current_level_nodes.push(node.val);

                    if let Some(left_child) = &node.left {
                        queue.push_back(left_child.clone());
                    }
                    if let Some(right_child) = &node.right {
                        queue.push_back(right_child.clone());
                    }
                }
            }

            if level_num % 2 == 1 {
                current_level_nodes.reverse();
            }

            result.push(current_level_nodes);
            level_num += 1;
        }

        result
    }
}