use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn largest_values(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut max_val = i32::min_value();

            for _ in 0..level_size {
                let node = queue.pop_front().unwrap();
                let node_ref = node.borrow();

                max_val = max_val.max(node_ref.val);

                if let Some(left) = &node_ref.left {
                    queue.push_back(Rc::clone(left));
                }
                if let Some(right) = &node_ref.right {
                    queue.push_back(Rc::clone(right));
                }
            }
            result.push(max_val);
        }

        result
    }
}