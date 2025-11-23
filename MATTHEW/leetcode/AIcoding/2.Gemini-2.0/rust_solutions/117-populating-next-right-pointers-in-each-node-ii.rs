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
        let mut head = root.clone();

        while let Some(head_ref) = head {
            let mut curr = head_ref.clone();
            let mut dummy = Node::new(0);
            let mut tail = Rc::new(RefCell::new(dummy));

            while let Some(curr_ref) = Some(curr.clone()) {
                let left = curr_ref.borrow().left.clone();
                let right = curr_ref.borrow().right.clone();

                if let Some(left_node) = left {
                    tail.borrow_mut().next = Some(left_node.clone());
                    tail = left_node;
                }

                if let Some(right_node) = right {
                    tail.borrow_mut().next = Some(right_node.clone());
                    tail = right_node;
                }

                if curr_ref.borrow().next.is_none() {
                    break;
                } else {
                    curr = curr_ref.borrow().next.clone().unwrap();
                }
            }

            head = {
                if let Some(next_head) = head_ref.borrow().left.clone() {
                    Some(next_head)
                } else if let Some(next_head) = head_ref.borrow().right.clone() {
                    Some(next_head)
                } else {
                    let mut next_head = head_ref.clone();
                    loop {
                        if next_head.borrow().next.is_none() {
                            break None;
                        }
                        next_head = next_head.borrow().next.clone().unwrap();
                        if next_head.borrow().left.is_some() {
                            break next_head.borrow().left.clone();
                        }
                        if next_head.borrow().right.is_some() {
                            break next_head.borrow().right.clone();
                        }
                    }
                }
            };
        }

        root
    }
}

struct Solution;