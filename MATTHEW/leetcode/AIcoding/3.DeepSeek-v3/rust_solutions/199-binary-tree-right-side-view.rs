use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn right_side_view(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        if root.is_none() {
            return result;
        }
        let mut queue = VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            for i in 0..level_size {
                let node = queue.pop_front().unwrap();
                let node = node.borrow();
                if i == level_size - 1 {
                    result.push(node.val);
                }
                if node.left.is_some() {
                    queue.push_back(node.left.as_ref().unwrap().clone());
                }
                if node.right.is_some() {
                    queue.push_back(node.right.as_ref().unwrap().clone());
                }
            }
        }
        result
    }
}