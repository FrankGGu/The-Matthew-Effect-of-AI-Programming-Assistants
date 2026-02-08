use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn width_of_binary_tree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if root.is_none() {
            return 0;
        }
        let mut max_width = 0;
        let mut queue = VecDeque::new();
        queue.push_back((root.unwrap(), 0));

        while !queue.is_empty() {
            let level_len = queue.len();
            let (_, first_pos) = queue.front().unwrap();
            let (_, last_pos) = queue.back().unwrap();
            max_width = max_width.max(last_pos - first_pos + 1);

            for _ in 0..level_len {
                let (node, pos) = queue.pop_front().unwrap();
                let node = node.borrow();
                if let Some(left) = node.left.clone() {
                    queue.push_back((left, pos * 2));
                }
                if let Some(right) = node.right.clone() {
                    queue.push_back((right, pos * 2 + 1));
                }
            }
        }

        max_width as i32
    }
}