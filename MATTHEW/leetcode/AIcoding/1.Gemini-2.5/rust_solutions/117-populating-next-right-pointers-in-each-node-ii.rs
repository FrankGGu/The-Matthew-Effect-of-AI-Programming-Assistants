use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

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

struct Solution;

impl Solution {
    pub fn connect(root: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        if root.is_none() {
            return None;
        }

        let mut q: VecDeque<Rc<RefCell<Node>>> = VecDeque::new();
        q.push_back(root.as_ref().unwrap().clone());

        while !q.is_empty() {
            let level_size = q.len();
            let mut prev_node_in_level: Option<Rc<RefCell<Node>>> = None;

            for _ in 0..level_size {
                let curr_node_rc = q.pop_front().unwrap();

                if let Some(prev_rc) = prev_node_in_level.take() {
                    prev_rc.borrow_mut().next = Some(Rc::clone(&curr_node_rc));
                }

                prev_node_in_level = Some(Rc::clone(&curr_node_rc));

                let curr_node = curr_node_rc.borrow();

                if let Some(left_child) = &curr_node.left {
                    q.push_back(Rc::clone(left_child));
                }
                if let Some(right_child) = &curr_node.right {
                    q.push_back(Rc::clone(right_child));
                }
            }
        }

        root
    }
}