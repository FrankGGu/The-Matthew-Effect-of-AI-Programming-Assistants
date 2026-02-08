use std::cell::RefCell;
use std::rc::Rc;

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn kth_smallest(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i32 {
    let mut stack = Vec::new();
    let mut current = root;
    let mut count = 0;

    while !stack.is_empty() || current.is_some() {
        while let Some(node) = current {
            stack.push(node.clone());
            current = node.borrow().left.clone();
        }
        current = stack.pop();
        count += 1;
        if count == k {
            return current.as_ref().unwrap().borrow().val;
        }
        current = current.unwrap().borrow().right.clone();
    }
    0
}