use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn expand_binary_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(node) = root {
            let left = node.borrow_mut().left.take();
            let right = node.borrow_mut().right.take();
            let expanded_left = Self::expand_binary_tree(left);
            let expanded_right = Self::expand_binary_tree(right);
            if expanded_left.is_some() {
                let new_node = Rc::new(RefCell::new(TreeNode::new(-1)));
                new_node.borrow_mut().left = expanded_left;
                node.borrow_mut().left = Some(new_node);
            }
            if expanded_right.is_some() {
                let new_node = Rc::new(RefCell::new(TreeNode::new(-1)));
                new_node.borrow_mut().right = expanded_right;
                node.borrow_mut().right = Some(new_node);
            }
            Some(node)
        } else {
            None
        }
    }
}