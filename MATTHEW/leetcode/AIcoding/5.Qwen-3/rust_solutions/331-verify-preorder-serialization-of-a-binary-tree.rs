impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn is_preorder_serialization(preorder: String) -> bool {
    let nodes: Vec<&str> = preorder.split(',').collect();
    let mut stack = vec![];
    for node in nodes {
        stack.push(node);
        while stack.len() >= 2 && stack[stack.len() - 1] == "#" && stack[stack.len() - 2] == "#" {
            stack.pop();
            stack.pop();
            if !stack.is_empty() {
                stack.pop();
                stack.push("#");
            }
        }
    }
    stack.len() == 1 && stack[0] == "#"
}
}