impl Solution {

use std::cell::RefCell;
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

pub fn amount_of_time(root: Option<Rc<RefCell<TreeNode>>>, start: i32) -> i32 {
    use std::collections::{HashMap, VecDeque};

    fn build_graph(
        root: &Option<Rc<RefCell<TreeNode>>>,
        graph: &mut HashMap<i32, Vec<i32>>,
        parent: i32,
    ) {
        if let Some(node) = root {
            let node_val = node.borrow().val;
            if parent != -1 {
                graph.entry(node_val).or_insert_with(Vec::new).push(parent);
                graph.entry(parent).or_insert_with(Vec::new).push(node_val);
            }

            build_graph(&node.borrow().left, graph, node_val);
            build_graph(&node.borrow().right, graph, node_val);
        }
    }

    let mut graph = HashMap::new();
    build_graph(&root, &mut graph, -1);

    let mut queue = VecDeque::new();
    queue.push_back((start, 0));
    let mut visited = std::collections::HashSet::new();
    visited.insert(start);

    while let Some((node, time)) = queue.pop_front() {
        for &neighbor in graph.get(&node).into_iter().flatten() {
            if !visited.contains(&neighbor) {
                visited.insert(neighbor);
                queue.push_back((neighbor, time + 1));
            }
        }
    }

    queue.back().map(|&(_, t)| t).unwrap_or(0)
}
}