use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn find_bottom_left_value(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        let mut bottom_left_value = 0;

        if let Some(node) = root {
            queue.push_back(node);
        } else {
            // According to problem constraints, the tree will have at least one node.
            // If an empty tree was possible, specific error handling or default return would be needed.
            return 0; 
        }

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut first_node_in_level = true;

            for _ in 0..level_size {
                let node_rc = queue.pop_front().unwrap();
                let node = node_rc.borrow();

                if first_node_in_level {
                    bottom_left_value = node.val;
                    first_node_in_level = false;
                }

                if let Some(left_child) = &node.left {
                    queue.push_back(Rc::clone(left_child));
                }
                if let Some(right_child) = &node.right {
                    queue.push_back(Rc::clone(right_child));
                }
            }
        }

        bottom_left_value
    }
}