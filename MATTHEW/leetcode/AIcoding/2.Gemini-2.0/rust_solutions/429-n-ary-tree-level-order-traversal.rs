use std::cell::RefCell;
use std::collections::VecDeque;
use std::rc::Rc;

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
    pub fn level_order(root: Option<Rc<RefCell<Node>>>) -> Vec<Vec<i32>> {
        let mut result: Vec<Vec<i32>> = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue: VecDeque<Rc<RefCell<Node>>> = VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut level_values: Vec<i32> = Vec::new();

            for _ in 0..level_size {
                let node = queue.pop_front().unwrap();
                level_values.push(node.borrow().val);

                for child in &node.borrow().children {
                    if let Some(child_node) = child {
                        queue.push_back(Rc::clone(child_node));
                    }
                }
            }

            result.push(level_values);
        }

        result
    }
}

struct Solution {}