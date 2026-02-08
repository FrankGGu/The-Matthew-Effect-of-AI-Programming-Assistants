use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn amount_of_time(root: Option<Rc<RefCell<TreeNode>>>, start: i32) -> i32 {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        Self::build_graph(&root, &mut graph);

        let mut queue = VecDeque::new();
        let mut visited = HashMap::new();
        queue.push_back(start);
        visited.insert(start, true);

        let mut time = -1;

        while !queue.is_empty() {
            let level_size = queue.len();
            for _ in 0..level_size {
                let current = queue.pop_front().unwrap();
                if let Some(neighbors) = graph.get(&current) {
                    for &neighbor in neighbors {
                        if !visited.contains_key(&neighbor) {
                            visited.insert(neighbor, true);
                            queue.push_back(neighbor);
                        }
                    }
                }
            }
            time += 1;
        }
        time
    }

    fn build_graph(root: &Option<Rc<RefCell<TreeNode>>>, graph: &mut HashMap<i32, Vec<i32>>) {
        if let Some(node) = root {
            let node = node.borrow();
            let val = node.val;
            if let Some(left) = &node.left {
                let left_val = left.borrow().val;
                graph.entry(val).or_default().push(left_val);
                graph.entry(left_val).or_default().push(val);
                Self::build_graph(&node.left, graph);
            }
            if let Some(right) = &node.right {
                let right_val = right.borrow().val;
                graph.entry(val).or_default().push(right_val);
                graph.entry(right_val).or_default().push(val);
                Self::build_graph(&node.right, graph);
            }
        }
    }
}