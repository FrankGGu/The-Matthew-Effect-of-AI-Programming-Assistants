use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn inorder_successor(root: Option<Rc<RefCell<TreeNode>>>, p: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut successor: Option<Rc<RefCell<TreeNode>>> = None;
        let mut current_root = root;

        // Extract the value of node p.
        // Problem constraints usually guarantee p is a valid node in the tree.
        let p_val = p.as_ref().unwrap().borrow().val;

        while let Some(node_rc) = current_root.clone() {
            let node = node_rc.borrow();
            if p_val < node.val {
                // If the current node's value is greater than p's value,
                // this node could be the inorder successor.
                // Store it and try to find a smaller one in its left subtree.
                successor = current_root.clone();
                current_root = node.left.clone();
            } else {
                // If the current node's value is less than or equal to p's value,
                // p must be in the right subtree (or is the current node itself).
                // We discard the current node and move to its right child.
                current_root = node.right.clone();
            }
        }
        successor
    }
}