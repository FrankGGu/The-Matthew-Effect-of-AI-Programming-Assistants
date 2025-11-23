use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Option<Rc<RefCell<Node>>>>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node { val, children: vec![] }
    }
}

impl Solution {
    pub fn postorder(root: Option<Rc<RefCell<Node>>>) -> Vec<i32> {
        let mut result = Vec::new();
        if let Some(node) = root {
            for child in &node.borrow().children {
                result.extend(Solution::postorder(child.clone()));
            }
            result.push(node.borrow().val);
        }
        result
    }
}

struct Solution;