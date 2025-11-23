use std::cell::RefCell;
use std::collections::HashMap;
use std::collections::HashSet;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

impl Solution {
    pub fn amount_of_time(root: Option<Rc<RefCell<TreeNode>>>, start: i32) -> i32 {
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();
        Self::build_graph(root.clone(), &mut adj);

        let mut visited: HashSet<i32> = HashSet::new();
        let mut queue: Vec<i32> = Vec::new();
        queue.push(start);
        visited.insert(start);

        let mut time = 0;
        while !queue.is_empty() {
            let mut next_queue: Vec<i32> = Vec::new();
            for node in queue {
                if let Some(neighbors) = adj.get(&node) {
                    for neighbor in neighbors {
                        if !visited.contains(neighbor) {
                            visited.insert(*neighbor);
                            next_queue.push(*neighbor);
                        }
                    }
                }
            }
            if !next_queue.is_empty() {
                time += 1;
            }
            queue = next_queue;
        }
        time
    }

    fn build_graph(root: Option<Rc<RefCell<TreeNode>>>, adj: &mut HashMap<i32, Vec<i32>>) {
        if let Some(node) = root {
            let val = node.borrow().val;
            if let Some(left) = &node.borrow().left {
                let left_val = left.borrow().val;
                adj.entry(val).or_insert(Vec::new()).push(left_val);
                adj.entry(left_val).or_insert(Vec::new()).push(val);
                Self::build_graph(Some(left.clone()), adj);
            }
            if let Some(right) = &node.borrow().right {
                let right_val = right.borrow().val;
                adj.entry(val).or_insert(Vec::new()).push(right_val);
                adj.entry(right_val).or_insert(Vec::new()).push(val);
                Self::build_graph(Some(right.clone()), adj);
            }
        }
    }
}

struct Solution;