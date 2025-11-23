use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{HashMap, VecDeque, HashSet};

impl Solution {
    pub fn amount_of_time(root: Option<Rc<RefCell<TreeNode>>>, start: i32) -> i32 {
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();
        Self::build_graph_recursive(root.clone(), &mut adj);
        Self::bfs_infection_time(start, &adj)
    }

    fn build_graph_recursive(
        node_opt: Option<Rc<RefCell<TreeNode>>>,
        adj: &mut HashMap<i32, Vec<i32>>,
    ) {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            let val = node.val;

            if let Some(left_rc) = node.left.clone() {
                let left_val = left_rc.borrow().val;
                adj.entry(val).or_default().push(left_val);
                adj.entry(left_val).or_default().push(val);
                Self::build_graph_recursive(Some(left_rc), adj);
            }

            if let Some(right_rc) = node.right.clone() {
                let right_val = right_rc.borrow().val;
                adj.entry(val).or_default().push(right_val);
                adj.entry(right_val).or_default().push(val);
                Self::build_graph_recursive(Some(right_rc), adj);
            }
        }
    }

    fn bfs_infection_time(start_node_val: i32, adj: &HashMap<i32, Vec<i32>>) -> i32 {
        let mut queue: VecDeque<(i32, i32)> = VecDeque::new(); // (node_val, time)
        let mut visited: HashSet<i32> = HashSet::new();
        let mut max_time = 0;

        queue.push_back((start_node_val, 0));
        visited.insert(start_node_val);

        while let Some((current_node_val, current_time)) = queue.pop_front() {
            max_time = max_time.max(current_time);

            if let Some(neighbors) = adj.get(&current_node_val) {
                for &neighbor_val in neighbors {
                    if visited.insert(neighbor_val) {
                        queue.push_back((neighbor_val, current_time + 1));
                    }
                }
            }
        }
        max_time
    }
}