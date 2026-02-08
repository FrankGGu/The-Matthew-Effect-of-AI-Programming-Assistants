use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn inorder_successor(root: Option<Rc<RefCell<TreeNode>>>, p: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let p_val = p.as_ref().unwrap().borrow().val;
        let mut current = root;
        let mut successor = None;

        while let Some(node) = current {
            let node_val = node.borrow().val;
            if node_val > p_val {
                successor = Some(node.clone());
                current = node.borrow().left.clone();
            } else {
                current = node.borrow().right.clone();
            }
        }

        successor
    }
}