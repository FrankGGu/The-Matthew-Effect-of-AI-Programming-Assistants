use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

impl Solution {
    pub fn is_complete_tree(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        let mut queue = VecDeque::new();
        queue.push_back(root);
        let mut seen_null = false;

        while let Some(node) = queue.pop_front() {
            match node {
                Some(n) => {
                    if seen_null {
                        return false;
                    }
                    let n = n.borrow();
                    queue.push_back(n.left.clone());
                    queue.push_back(n.right.clone());
                },
                None => {
                    seen_null = true;
                }
            }
        }
        true
    }
}