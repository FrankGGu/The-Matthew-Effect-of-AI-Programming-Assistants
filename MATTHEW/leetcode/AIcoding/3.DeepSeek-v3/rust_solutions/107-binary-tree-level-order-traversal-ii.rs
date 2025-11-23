use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn level_order_bottom(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        if root.is_none() {
            return result;
        }
        let mut queue = VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut current_level = Vec::with_capacity(level_size);

            for _ in 0..level_size {
                let node = queue.pop_front().unwrap();
                let node = node.borrow();
                current_level.push(node.val);

                if node.left.is_some() {
                    queue.push_back(node.left.as_ref().unwrap().clone());
                }
                if node.right.is_some() {
                    queue.push_back(node.right.as_ref().unwrap().clone());
                }
            }
            result.push(current_level);
        }
        result.reverse();
        result
    }
}