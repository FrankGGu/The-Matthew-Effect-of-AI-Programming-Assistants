impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Rc<RefCell<Node>>>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node { val, children: vec![] }
    }
}

pub fn preorder(root: Option<Rc<RefCell<Node>>>) -> Vec<i32> {
    let mut result = Vec::new();
    if let Some(node) = root {
        let mut stack = vec![node];
        while let Some(current) = stack.pop() {
            let current_ref = current.borrow();
            result.push(current_ref.val);
            for child in current_ref.children.iter().rev() {
                stack.push(child.clone());
            }
        }
    }
    result
}
}