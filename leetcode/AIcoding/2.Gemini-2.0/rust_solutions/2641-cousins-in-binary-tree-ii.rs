use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn replace_value_in_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let root = root.unwrap();
        root.borrow_mut().val = 0;

        let mut queue = vec![root.clone()];

        while !queue.is_empty() {
            let mut next_level = vec![];
            let mut level_sum = 0;

            for node in &queue {
                if let Some(left) = &node.borrow().left {
                    level_sum += left.borrow().val;
                    next_level.push(left.clone());
                }
                if let Some(right) = &node.borrow().right {
                    level_sum += right.borrow().val;
                    next_level.push(right.clone());
                }
            }

            for node in &queue {
                let mut children_sum = 0;
                if let Some(left) = &node.borrow().left {
                    children_sum += left.borrow().val;
                }
                if let Some(right) = &node.borrow().right {
                    children_sum += right.borrow().val;
                }

                if let Some(left) = &node.borrow().left {
                    left.borrow_mut().val = level_sum - children_sum;
                }
                if let Some(right) = &node.borrow().right {
                    right.borrow_mut().val = level_sum - children_sum;
                }
            }

            queue = next_level;
        }

        Some(root)
    }
}