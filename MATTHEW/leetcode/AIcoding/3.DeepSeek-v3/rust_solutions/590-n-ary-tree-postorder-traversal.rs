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

pub fn postorder(root: Option<Rc<RefCell<Node>>>) -> Vec<i32> {
    let mut result = Vec::new();
    if let Some(node) = root {
        let node = node.borrow();
        for child in &node.children {
            result.extend(postorder(Some(Rc::clone(child))));
        }
        result.push(node.val);
    }
    result
}