use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;
use std::cmp::max;

impl Solution {
    pub fn width_of_binary_tree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if root.is_none() {
            return 0;
        }

        let mut max_width: u64 = 0;
        let mut q: VecDeque<(Rc<RefCell<TreeNode>>, u64)> = VecDeque::new();
        q.push_back((root.unwrap(), 0));

        while !q.is_empty() {
            let level_len = q.len();

            let first_pos_in_level = q.front().unwrap().1;
            let last_pos_in_level = q.back().unwrap().1;

            max_width = max(max_width, last_pos_in_level - first_pos_in_level + 1);

            for _ in 0..level_len {
                let (node_rc, current_pos_abs) = q.pop_front().unwrap();
                let node = node_rc.borrow();

                let normalized_pos = current_pos_abs - first_pos_in_level;

                if let Some(left_child) = node.left.clone() {
                    q.push_back((left_child, 2 * normalized_pos));
                }
                if let Some(right_child) = node.right.clone() {
                    q.push_back((right_child, 2 * normalized_pos + 1));
                }
            }
        }

        max_width as i32
    }
}