use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug)]
pub struct Node {
    pub val: i32,
    pub children: Vec<Rc<RefCell<Node>>>,
}

impl Node {
    #[inline]
    fn new(val: i32) -> Self {
        Node {
            val,
            children: Vec::new(),
        }
    }
}

pub fn max_depth(root: Option<Rc<RefCell<Node>>>) -> i32 {
    match root {
        Some(node) => {
            let mut depth = 1;
            for child in node.borrow().children.iter() {
                depth = depth.max(max_depth(Some(child.clone())) + 1);
            }
            depth
        },
        None => 0,
    }
}