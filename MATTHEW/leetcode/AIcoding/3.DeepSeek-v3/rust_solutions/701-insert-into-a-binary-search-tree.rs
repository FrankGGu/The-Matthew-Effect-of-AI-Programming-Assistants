use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn insert_into_bst(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return Some(Rc::new(RefCell::new(TreeNode::new(val))));
        }
        let node = root.clone();
        let mut current = node;
        while let Some(curr) = current {
            let mut curr_node = curr.borrow_mut();
            if val < curr_node.val {
                if curr_node.left.is_none() {
                    curr_node.left = Some(Rc::new(RefCell::new(TreeNode::new(val))));
                    break;
                } else {
                    current = curr_node.left.clone();
                }
            } else {
                if curr_node.right.is_none() {
                    curr_node.right = Some(Rc::new(RefCell::new(TreeNode::new(val))));
                    break;
                } else {
                    current = curr_node.right.clone();
                }
            }
        }
        root
    }
}