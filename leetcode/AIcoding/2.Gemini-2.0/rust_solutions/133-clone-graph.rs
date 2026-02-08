use std::collections::{HashMap, VecDeque};
use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq, Clone)]
pub struct Node {
    pub val: i32,
    pub neighbors: Vec<Option<Rc<RefCell<Node>>>>,
}

impl Node {
    #[inline]
    pub fn new(val: i32) -> Self {
        Node {
            val,
            neighbors: Vec::new(),
        }
    }
}

impl Solution {
    pub fn clone_graph(node: Option<Rc<RefCell<Node>>>) -> Option<Rc<RefCell<Node>>> {
        if node.is_none() {
            return None;
        }

        let mut visited: HashMap<i32, Rc<RefCell<Node>>> = HashMap::new();
        let mut queue: VecDeque<Rc<RefCell<Node>>> = VecDeque::new();

        let original_node = node.unwrap();
        let cloned_node = Rc::new(RefCell::new(Node::new(original_node.borrow().val)));
        visited.insert(original_node.borrow().val, cloned_node.clone());
        queue.push_back(original_node.clone());

        while let Some(current_node) = queue.pop_front() {
            let current_node_val = current_node.borrow().val;
            let current_cloned_node = visited.get(&current_node_val).unwrap().clone();

            for neighbor_option in &current_node.borrow().neighbors {
                if let Some(neighbor) = neighbor_option {
                    let neighbor_val = neighbor.borrow().val;

                    if !visited.contains_key(&neighbor_val) {
                        let cloned_neighbor = Rc::new(RefCell::new(Node::new(neighbor_val)));
                        visited.insert(neighbor_val, cloned_neighbor.clone());
                        queue.push_back(neighbor.clone());
                    }

                    let cloned_neighbor = visited.get(&neighbor_val).unwrap().clone();
                    current_cloned_node.borrow_mut().neighbors.push(Some(cloned_neighbor.clone()));
                }
            }
        }

        Some(cloned_node)
    }
}

struct Solution;