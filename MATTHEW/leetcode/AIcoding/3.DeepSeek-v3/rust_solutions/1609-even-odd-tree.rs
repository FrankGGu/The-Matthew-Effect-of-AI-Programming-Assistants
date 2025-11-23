use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn is_even_odd_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return true;
        }
        let mut queue = VecDeque::new();
        queue.push_back(root.unwrap());
        let mut level = 0;

        while !queue.is_empty() {
            let size = queue.len();
            let mut prev = if level % 2 == 0 { i32::MIN } else { i32::MAX };

            for _ in 0..size {
                let node = queue.pop_front().unwrap();
                let node = node.borrow();
                let val = node.val;

                if level % 2 == 0 {
                    if val % 2 == 0 || val <= prev {
                        return false;
                    }
                } else {
                    if val % 2 != 0 || val >= prev {
                        return false;
                    }
                }
                prev = val;

                if let Some(left) = &node.left {
                    queue.push_back(Rc::clone(left));
                }
                if let Some(right) = &node.right {
                    queue.push_back(Rc::clone(right));
                }
            }
            level += 1;
        }
        true
    }
}