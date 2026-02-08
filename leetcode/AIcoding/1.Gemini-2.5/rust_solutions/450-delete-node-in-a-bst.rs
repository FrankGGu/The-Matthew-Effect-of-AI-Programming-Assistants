use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn delete_node(root: Option<Rc<RefCell<TreeNode>>>, key: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let node_rc = root.as_ref().unwrap();
        let mut node = node_rc.borrow_mut();

        if key < node.val {
            node.left = Self::delete_node(node.left.take(), key);
            root
        } else if key > node.val {
            node.right = Self::delete_node(node.right.take(), key);
            root
        } else { // key == node.val, this is the node to delete
            // Case 1: Node is a leaf or has only one child
            if node.left.is_none() {
                return node.right.take();
            }
            if node.right.is_none() {
                return node.left.take();
            }

            // Case 2: Node has two children
            // Find the in-order successor (smallest node in the right subtree)
            let mut successor_rc = node.right.as_ref().unwrap().clone();
            while successor_rc.borrow().left.is_some() {
                let next_left = successor_rc.borrow().left.as_ref().unwrap().clone();
                successor_rc = next_left;
            }
            let successor_val = successor_rc.borrow().val;

            // Replace current node's value with successor's value
            node.val = successor_val;

            // Delete the successor from the right subtree
            node.right = Self::delete_node(node.right.take(), successor_val);
            root
        }
    }
}