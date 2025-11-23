use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn find_bottom_left_value(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        let mut bottom_left_val = 0;

        if let Some(node) = root {
            queue.push_back(node);
        } else {
            return 0;
        }

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut first_node_in_level_processed = false;

            for _ in 0..level_size {
                let node_rc = queue.pop_front().unwrap();
                let node = node_rc.borrow();

                if !first_node_in_level_processed {
                    bottom_left_val = node.val;
                    first_node_in_level_processed = true;
                }

                if let Some(left_child) = node.left.clone() {
                    queue.push_back(left_child);
                }
                if let Some(right_child) = node.right.clone() {
                    queue.push_back(right_child);
                }
            }
        }

        bottom_left_val
    }
}