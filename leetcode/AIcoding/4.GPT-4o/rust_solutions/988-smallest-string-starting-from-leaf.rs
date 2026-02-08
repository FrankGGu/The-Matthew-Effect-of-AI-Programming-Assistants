use std::cell::RefCell;
use std::cmp::Ordering;
use std::collections::VecDeque;
use std::rc::Rc;

#[derive(Debug)]
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

pub fn smallest_from_leaf(root: Option<Rc<RefCell<TreeNode>>>) -> String {
    let mut result = String::from("~");
    let mut stack: Vec<(Option<Rc<RefCell<TreeNode>>>, String)> = Vec::new();
    stack.push((root, String::new()));

    while let Some((node, path)) = stack.pop() {
        if let Some(n) = node {
            let ch = (n.borrow().val as u8 + b'a') as char;
            let mut new_path = ch.to_string() + &path;

            if n.borrow().left.is_none() && n.borrow().right.is_none() {
                if new_path < result {
                    result = new_path;
                }
            } else {
                stack.push((n.borrow().left.clone(), new_path.clone()));
                stack.push((n.borrow().right.clone(), new_path));
            }
        }
    }

    result
}