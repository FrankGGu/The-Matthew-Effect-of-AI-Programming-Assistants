use std::collections::{HashMap, HashSet, VecDeque};
use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn distance_k(
        root: Option<Rc<RefCell<TreeNode>>>,
        target: Option<Rc<RefCell<TreeNode>>>,
        k: i32,
    ) -> Vec<i32> {
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();

        fn build_graph(
            node: Option<Rc<RefCell<TreeNode>>>,
            adj: &mut HashMap<i32, Vec<i32>>,
        ) {
            if let Some(n) = node {
                let val = n.borrow().val;
                if let Some(left) = n.borrow().left.clone() {
                    let left_val = left.borrow().val;
                    adj.entry(val).or_insert(Vec::new()).push(left_val);
                    adj.entry(left_val).or_insert(Vec::new()).push(val);
                    build_graph(Some(left), adj);
                }
                if let Some(right) = n.borrow().right.clone() {
                    let right_val = right.borrow().val;
                    adj.entry(val).or_insert(Vec::new()).push(right_val);
                    adj.entry(right_val).or_insert(Vec::new()).push(val);
                    build_graph(Some(right), adj);
                }
            }
        }

        build_graph(root.clone(), &mut adj);

        let target_val = target.unwrap().borrow().val;
        let mut q: VecDeque<(i32, i32)> = VecDeque::new();
        q.push_back((target_val, 0));
        let mut visited: HashSet<i32> = HashSet::new();
        visited.insert(target_val);

        let mut result: Vec<i32> = Vec::new();
        while let Some((node, dist)) = q.pop_front() {
            if dist == k {
                result.push(node);
            } else if dist < k {
                if let Some(neighbors) = adj.get(&node) {
                    for &neighbor in neighbors {
                        if !visited.contains(&neighbor) {
                            q.push_back((neighbor, dist + 1));
                            visited.insert(neighbor);
                        }
                    }
                }
            }
        }

        result
    }
}