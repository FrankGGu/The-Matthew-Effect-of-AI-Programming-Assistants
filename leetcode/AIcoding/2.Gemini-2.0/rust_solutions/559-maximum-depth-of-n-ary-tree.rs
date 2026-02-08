use std::rc::Rc;
use std::cell::RefCell;

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

impl Solution {
    pub fn max_depth(root: Option<Rc<RefCell<Node>>>) -> i32 {
        match root {
            None => 0,
            Some(node) => {
                let mut max_child_depth = 0;
                for child in &node.borrow().children {
                    max_child_depth = std::cmp::max(max_child_depth, Solution::max_depth(child.clone()));
                }
                1 + max_child_depth
            }
        }
    }
}

struct Solution;