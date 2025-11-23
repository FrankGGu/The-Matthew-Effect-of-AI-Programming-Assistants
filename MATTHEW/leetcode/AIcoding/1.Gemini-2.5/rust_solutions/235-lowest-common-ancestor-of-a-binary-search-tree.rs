use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn lowest_common_ancestor(root: Option<Rc<RefCell<TreeNode>>>, p: Option<Rc<RefCell<TreeNode>>>, q: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let p_val = p.as_ref().unwrap().borrow().val;
        let q_val = q.as_ref().unwrap().borrow().val;

        let mut current_node_option = root;

        while let Some(node_rc) = current_node_option {
            let node_val = node_rc.borrow().val;

            if p_val < node_val && q_val < node_val {
                // Both p and q are in the left subtree, so move left
                current_node_option = node_rc.borrow().left.clone();
            } else if p_val > node_val && q_val > node_val {
                // Both p and q are in the right subtree, so move right
                current_node_option = node_rc.borrow().right.clone();
            } else {
                // This is the LCA. It means:
                // 1. One value is less than or equal to node_val, and the other is greater than or equal to node_val.
                //    This covers cases where p is in left, q is in right (or vice versa),
                //    or where node_rc itself is p or q.
                return Some(node_rc.clone());
            }
        }
        unreachable!() // Problem constraints guarantee p and q are in the BST.
    }
}