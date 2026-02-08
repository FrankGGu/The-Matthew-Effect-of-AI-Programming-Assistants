use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn level_order(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut current_level_nodes: Vec<i32> = Vec::new();

            for _ in 0..level_size {
                if let Some(node_rc) = queue.pop_front() {
                    let node = node_rc.borrow();
                    current_level_nodes.push(node.val);

                    if let Some(left_child) = node.left.clone() {
                        queue.push_back(left_child);
                    }
                    if let Some(right_child) = node.right.clone() {
                        queue.push_back(right_child);
                    }
                }
            }
            result.push(current_level_nodes);
        }
        result
    }
}