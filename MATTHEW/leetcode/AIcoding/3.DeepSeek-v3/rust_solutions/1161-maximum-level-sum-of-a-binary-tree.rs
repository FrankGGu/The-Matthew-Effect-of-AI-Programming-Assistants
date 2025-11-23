use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn max_level_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_sum = i32::MIN;
        let mut max_level = 0;
        let mut level = 1;
        let mut queue = VecDeque::new();

        if let Some(node) = root {
            queue.push_back(node);
        }

        while !queue.is_empty() {
            let mut current_sum = 0;
            let level_size = queue.len();

            for _ in 0..level_size {
                if let Some(node) = queue.pop_front() {
                    let node = node.borrow();
                    current_sum += node.val;

                    if let Some(left) = &node.left {
                        queue.push_back(left.clone());
                    }
                    if let Some(right) = &node.right {
                        queue.push_back(right.clone());
                    }
                }
            }

            if current_sum > max_sum {
                max_sum = current_sum;
                max_level = level;
            }
            level += 1;
        }

        max_level
    }
}