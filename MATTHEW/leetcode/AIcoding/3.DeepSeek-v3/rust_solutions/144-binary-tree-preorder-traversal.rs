use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn preorder_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut stack = Vec::new();
        if let Some(node) = root {
            stack.push(node);
        }
        while let Some(node) = stack.pop() {
            let node = node.borrow();
            result.push(node.val);
            if let Some(right) = node.right.clone() {
                stack.push(right);
            }
            if let Some(left) = node.left.clone() {
                stack.push(left);
            }
        }
        result
    }
}