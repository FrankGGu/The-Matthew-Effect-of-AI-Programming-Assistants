use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn right_side_view(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue = std::collections::VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut rightmost_value = None;

            for _ in 0..level_size {
                if let Some(node) = queue.pop_front() {
                    let borrowed_node = node.borrow();
                    rightmost_value = Some(borrowed_node.val);

                    if let Some(left) = borrowed_node.left.clone() {
                        queue.push_back(left);
                    }
                    if let Some(right) = borrowed_node.right.clone() {
                        queue.push_back(right);
                    }
                }
            }

            if let Some(val) = rightmost_value {
                result.push(val);
            }
        }

        result
    }
}