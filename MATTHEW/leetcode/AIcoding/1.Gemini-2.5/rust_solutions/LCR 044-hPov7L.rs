use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn largest_values(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue = VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut current_max = i32::MIN;

            for _ in 0..level_size {
                let node_rc = queue.pop_front().unwrap();
                let node = node_rc.borrow();

                current_max = current_max.max(node.val);

                if let Some(left_child) = node.left.clone() {
                    queue.push_back(left_child);
                }
                if let Some(right_child) = node.right.clone() {
                    queue.push_back(right_child);
                }
            }
            result.push(current_max);
        }

        result
    }
}