use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn inorder_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut res = Vec::new();
        let mut stack = Vec::new();
        let mut current = root;

        while current.is_some() || !stack.is_empty() {
            while let Some(node) = current {
                stack.push(Rc::clone(&node));
                current = node.borrow().left.clone();
            }
            current = stack.pop();
            if let Some(node) = current {
                res.push(node.borrow().val);
                current = node.borrow().right.clone();
            }
        }
        res
    }
}