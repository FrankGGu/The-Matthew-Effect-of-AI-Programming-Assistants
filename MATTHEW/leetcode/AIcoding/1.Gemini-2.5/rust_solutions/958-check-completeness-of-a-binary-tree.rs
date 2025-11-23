use std::collections::VecDeque;
use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_complete_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return true;
        }

        let mut queue: VecDeque<Option<Rc<RefCell<TreeNode>>>> = VecDeque::new();
        queue.push_back(root);

        let mut found_null = false;

        while let Some(node_option) = queue.pop_front() {
            if let Some(node_rc) = node_option {
                if found_null {
                    return false;
                }

                let node = node_rc.borrow();
                queue.push_back(node.left.clone());
                queue.push_back(node.right.clone());
            } else {
                found_null = true;
            }
        }

        true
    }
}