use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn find_bottom_left_value(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut queue = VecDeque::new();
        if let Some(node) = root {
            queue.push_back(node);
        }
        let mut leftmost = 0;

        while !queue.is_empty() {
            let level_size = queue.len();
            for i in 0..level_size {
                let node = queue.pop_front().unwrap();
                let node_ref = node.borrow();
                if i == 0 {
                    leftmost = node_ref.val;
                }
                if let Some(left) = &node_ref.left {
                    queue.push_back(Rc::clone(left));
                }
                if let Some(right) = &node_ref.right {
                    queue.push_back(Rc::clone(right));
                }
            }
        }

        leftmost
    }
}