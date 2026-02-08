use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

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
      children: Vec::new(),
    }
  }
}

impl Solution {
    pub fn level_order(root: Option<Rc<RefCell<Node>>>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut queue: VecDeque<Rc<RefCell<Node>>> = VecDeque::new();

        if let Some(node) = root {
            queue.push_back(node);
        }

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut current_level_values: Vec<i32> = Vec::with_capacity(level_size);

            for _ in 0..level_size {
                if let Some(node_rc) = queue.pop_front() {
                    let node_borrow = node_rc.borrow();
                    current_level_values.push(node_borrow.val);

                    for child_rc in &node_borrow.children {
                        queue.push_back(Rc::clone(child_rc));
                    }
                }
            }
            result.push(current_level_values);
        }

        result
    }
}