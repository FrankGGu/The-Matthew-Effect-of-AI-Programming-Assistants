use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_subtree(root: Option<Rc<RefCell<TreeNode>>>, sub_root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if sub_root.is_none() {
            return true;
        }
        if root.is_none() {
            return false;
        }
        if Self::is_same_tree(root.clone(), sub_root.clone()) {
            return true;
        }
        let root_node = root.unwrap();
        let left = root_node.borrow().left.clone();
        let right = root_node.borrow().right.clone();
        Self::is_subtree(left, sub_root.clone()) || Self::is_subtree(right, sub_root)
    }

    fn is_same_tree(p: Option<Rc<RefCell<TreeNode>>>, q: Option<Rc<RefCell<TreeNode>>>) -> bool {
        match (p, q) {
            (None, None) => true,
            (Some(p_node), Some(q_node)) => {
                let p_node = p_node.borrow();
                let q_node = q_node.borrow();
                p_node.val == q_node.val 
                    && Self::is_same_tree(p_node.left.clone(), q_node.left.clone())
                    && Self::is_same_tree(p_node.right.clone(), q_node.right.clone())
            }
            _ => false,
        }
    }
}