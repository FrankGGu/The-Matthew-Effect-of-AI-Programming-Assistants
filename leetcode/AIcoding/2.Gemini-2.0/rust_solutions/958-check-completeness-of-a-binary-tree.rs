use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn is_complete_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return true;
        }

        let mut queue = std::collections::VecDeque::new();
        queue.push_back(root);

        let mut seen_null = false;

        while !queue.is_empty() {
            if let Some(node) = queue.pop_front().unwrap() {
                let node_ref = node.borrow();

                if seen_null {
                    return false;
                }

                if node_ref.left.is_some() {
                    queue.push_back(node_ref.left.clone());
                } else {
                    seen_null = true;
                }

                if node_ref.right.is_some() {
                    queue.push_back(node_ref.right.clone());
                } else {
                    seen_null = true;
                }
            } else {
                seen_null = true;
            }
        }

        true
    }
}