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
        Node {
            val,
            children: vec![],
        }
    }
}

impl Solution {
    pub fn max_depth(root: Option<Rc<RefCell<Node>>>) -> i32 {
        match root {
            None => 0,
            Some(node_rc) => {
                let node = node_rc.borrow();
                let mut max_child_depth = 0;
                for child in node.children.iter() {
                    max_child_depth = max_child_depth.max(Solution::max_depth(Some(child.clone())));
                }
                1 + max_child_depth
            }
        }
    }
}