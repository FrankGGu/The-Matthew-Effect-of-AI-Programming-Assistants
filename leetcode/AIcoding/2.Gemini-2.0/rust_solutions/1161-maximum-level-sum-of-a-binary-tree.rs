use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn max_level_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut queue = std::collections::VecDeque::new();
        if let Some(node) = root {
            queue.push_back(node);
        }

        let mut max_sum = i32::min_value();
        let mut max_level = 0;
        let mut level = 1;

        while !queue.is_empty() {
            let mut level_sum = 0;
            let level_size = queue.len();

            for _ in 0..level_size {
                if let Some(node) = queue.pop_front() {
                    level_sum += node.borrow().val;

                    if let Some(left) = &node.borrow().left {
                        queue.push_back(Rc::clone(left));
                    }
                    if let Some(right) = &node.borrow().right {
                        queue.push_back(Rc::clone(right));
                    }
                }
            }

            if level_sum > max_sum {
                max_sum = level_sum;
                max_level = level;
            }

            level += 1;
        }

        max_level
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
            right: None,
        }
    }
}

struct Solution;