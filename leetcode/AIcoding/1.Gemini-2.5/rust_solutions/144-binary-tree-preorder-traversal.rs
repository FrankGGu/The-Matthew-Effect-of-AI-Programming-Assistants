use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn preorder_traversal(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        Self::preorder_helper(root, &mut result);
        result
    }

    fn preorder_helper(node: Option<Rc<RefCell<TreeNode>>>, result: &mut Vec<i32>) {
        if let Some(rc_node) = node {
            let node_ref = rc_node.borrow();
            result.push(node_ref.val);
            Self::preorder_helper(node_ref.left.clone(), result);
            Self::preorder_helper(node_ref.right.clone(), result);
        }
    }
}