use std::rc::Rc;
use std::cell::RefCell;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn max_depth(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn depth(node: Option<&Rc<RefCell<TreeNode>>>) -> i32 {
        match node {
            Some(n) => {
                let left_depth = depth(n.borrow().left.as_ref());
                let right_depth = depth(n.borrow().right.as_ref());
                1 + left_depth.max(right_depth)
            }
            None => 0,
        }
    }
    depth(root.as_ref())
}