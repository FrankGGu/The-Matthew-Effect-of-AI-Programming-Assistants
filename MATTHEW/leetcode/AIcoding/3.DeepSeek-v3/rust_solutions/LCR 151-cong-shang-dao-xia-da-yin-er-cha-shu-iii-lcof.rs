use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn decorate_record(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
        let mut res = Vec::new();
        if root.is_none() {
            return res;
        }
        let mut queue = VecDeque::new();
        queue.push_back(root);
        let mut is_odd = true;
        while !queue.is_empty() {
            let level_size = queue.len();
            let mut level = Vec::with_capacity(level_size);
            for _ in 0..level_size {
                if let Some(node) = queue.pop_front().unwrap() {
                    level.push(node.borrow().val);
                    queue.push_back(node.borrow().left.clone());
                    queue.push_back(node.borrow().right.clone());
                }
            }
            if !level.is_empty() {
                if !is_odd {
                    level.reverse();
                }
                res.push(level);
            }
            is_odd = !is_odd;
        }
        res
    }
}