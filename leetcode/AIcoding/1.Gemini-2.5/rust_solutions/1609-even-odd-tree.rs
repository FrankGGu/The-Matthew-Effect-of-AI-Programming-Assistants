use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn is_even_odd_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return true;
        }

        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        queue.push_back(root.unwrap());
        let mut level = 0;

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut prev_val: i32;

            if level % 2 == 0 { // Even level: values must be odd and strictly increasing
                prev_val = 0; // Smallest possible value for comparison (Node.val >= 1)
            } else { // Odd level: values must be even and strictly decreasing
                prev_val = 1_000_001; // Largest possible value for comparison (Node.val <= 10^6)
            }

            for _ in 0..level_size {
                let node_rc = queue.pop_front().unwrap();
                let node = node_rc.borrow();

                if level % 2 == 0 { // Even level
                    // Value must be odd
                    if node.val % 2 == 0 {
                        return false;
                    }
                    // Value must be strictly increasing
                    if node.val <= prev_val {
                        return false;
                    }
                } else { // Odd level
                    // Value must be even
                    if node.val % 2 != 0 {
                        return false;
                    }
                    // Value must be strictly decreasing
                    if node.val >= prev_val {
                        return false;
                    }
                }
                prev_val = node.val;

                if let Some(left_child) = node.left.clone() {
                    queue.push_back(left_child);
                }
                if let Some(right_child) = node.right.clone() {
                    queue.push_back(right_child);
                }
            }
            level += 1;
        }

        true
    }
}