use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct Node {
  pub val: i32,
  pub prev: Option<Rc<RefCell<Node>>>,
  pub next: Option<Rc<RefCell<Node>>>,
  pub child: Option<Rc<RefCell<Node>>>,
}

impl Node {
  #[inline]
  pub fn new(val: i32) -> Self {
    Node {
      val: val,
      prev: None,
      next: None,
      child: None,
    }
  }
}

struct Solution;

impl Solution {
    pub fn flatten(head: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        if head.is_none() {
            return None;
        }

        let mut current_opt = head.clone();

        while let Some(current_rc) = current_opt {
            let mut current_node = current_rc.borrow_mut();

            if let Some(child_rc) = current_node.child.take() {
                let next_node_opt = current_node.next.take();

                current_node.next = Some(child_rc.clone());
                child_rc.borrow_mut().prev = Some(current_rc.clone());

                let mut child_tail_opt = Some(child_rc.clone());
                while let Some(tail_rc_inner) = child_tail_opt.clone() {
                    if tail_rc_inner.borrow().next.is_none() {
                        child_tail_opt = Some(tail_rc_inner);
                        break;
                    }
                    child_tail_opt = tail_rc_inner.borrow().next.clone();
                }

                if let Some(tail_rc) = child_tail_opt {
                    tail_rc.borrow_mut().next = next_node_opt.clone();
                }

                if let Some(next_rc) = next_node_opt {
                    next_rc.borrow_mut().prev = child_tail_opt;
                }
            }

            current_opt = current_rc.borrow().next.clone();
        }

        head
    }
}