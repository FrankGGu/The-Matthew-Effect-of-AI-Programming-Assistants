use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
    pub val: i32,
    pub left: Option<Rc<RefCell<Node>>>,
    pub right: Option<Rc<RefCell<Node>>>,
    pub next: Option<Rc<RefCell<Node>>>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node {
            val,
            left: None,
            right: None,
            next: None,
        }
    }
}

impl Solution {
    pub fn connect(root: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        if root.is_none() {
            return root;
        }

        let root = root.unwrap();
        let mut level_start = Some(Rc::clone(&root));

        while let Some(node) = level_start {
            let mut curr = Some(Rc::clone(&node));
            let mut next_level_start = None;

            while let Some(curr_node) = curr {
                let curr_node_borrow = curr_node.borrow();
                if curr_node_borrow.left.is_some() {
                    if next_level_start.is_none() {
                        next_level_start = Some(Rc::clone(curr_node_borrow.left.as_ref().unwrap()));
                    }

                    if curr_node_borrow.right.is_some() {
                        curr_node_borrow.left.as_ref().unwrap().borrow_mut().next =
                            Some(Rc::clone(curr_node_borrow.right.as_ref().unwrap()));
                    }
                }

                if curr_node_borrow.right.is_some() && curr_node_borrow.next.is_some() {
                    curr_node_borrow.right.as_ref().unwrap().borrow_mut().next =
                        curr_node_borrow.next.as_ref().unwrap().borrow().left.clone();
                }

                curr = curr_node_borrow.next.clone();
            }

            level_start = next_level_start;
        }

        Some(root)
    }
}

struct Solution;