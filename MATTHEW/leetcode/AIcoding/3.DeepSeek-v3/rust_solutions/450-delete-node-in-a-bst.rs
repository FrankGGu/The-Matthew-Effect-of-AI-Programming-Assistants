use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn delete_node(root: Option<Rc<RefCell<TreeNode>>>, key: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node) = root {
            let mut node_ref = node.borrow_mut();
            if key < node_ref.val {
                let left = Self::delete_node(node_ref.left.take(), key);
                node_ref.left = left;
                return Some(node.clone());
            } else if key > node_ref.val {
                let right = Self::delete_node(node_ref.right.take(), key);
                node_ref.right = right;
                return Some(node.clone());
            } else {
                if node_ref.left.is_none() {
                    return node_ref.right.clone();
                } else if node_ref.right.is_none() {
                    return node_ref.left.clone();
                } else {
                    let min_node = Self::find_min(node_ref.right.clone());
                    if let Some(min_node) = min_node {
                        let min_val = min_node.borrow().val;
                        let right = Self::delete_node(node_ref.right.take(), min_val);
                        node_ref.right = right;
                        node_ref.val = min_val;
                    }
                    return Some(node.clone());
                }
            }
        }
        None
    }

    fn find_min(node: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        let mut current = node;
        while let Some(n) = current.clone() {
            if n.borrow().left.is_none() {
                break;
            }
            current = n.borrow().left.clone();
        }
        current
    }
}