#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Option<Rc<RefCell<Node>>>>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node {
            val,
            children: Vec::new(),
        }
    }
}

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn preorder(root: Option<Rc<RefCell<Node>>>) -> Vec<i32> {
        let mut result = Vec::new();
        if let Some(node) = root {
            result.push(node.borrow().val);
            for child in &node.borrow().children {
                result.extend(Solution::preorder(child.clone()));
            }
        }
        result
    }
}

struct Solution;