use std::rc::Rc;
use std::cell::RefCell;
use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn distance_k(root: Option<Rc<RefCell<TreeNode>>>, target: Option<Rc<RefCell<TreeNode>>>, k: i32) -> Vec<i32> {
        let mut parent_map = HashMap::new();
        Self::build_parent_map(root.clone(), &mut parent_map);

        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        if let Some(target_node) = target {
            queue.push_back((target_node, 0));
            visited.insert(target_node.borrow().val);
        }

        let mut result = Vec::new();

        while let Some((node, distance)) = queue.pop_front() {
            if distance == k {
                result.push(node.borrow().val);
                continue;
            }

            let node_ref = node.borrow();

            if let Some(left) = node_ref.left.clone() {
                if !visited.contains(&left.borrow().val) {
                    visited.insert(left.borrow().val);
                    queue.push_back((left, distance + 1));
                }
            }

            if let Some(right) = node_ref.right.clone() {
                if !visited.contains(&right.borrow().val) {
                    visited.insert(right.borrow().val);
                    queue.push_back((right, distance + 1));
                }
            }

            if let Some(parent) = parent_map.get(&node_ref.val) {
                if !visited.contains(&parent.borrow().val) {
                    visited.insert(parent.borrow().val);
                    queue.push_back((parent.clone(), distance + 1));
                }
            }
        }

        result
    }

    fn build_parent_map(root: Option<Rc<RefCell<TreeNode>>>, parent_map: &mut HashMap<i32, Rc<RefCell<TreeNode>>>) {
        if let Some(node) = root {
            let node_ref = node.borrow();
            if let Some(left) = node_ref.left.clone() {
                parent_map.insert(left.borrow().val, node.clone());
                Self::build_parent_map(Some(left), parent_map);
            }
            if let Some(right) = node_ref.right.clone() {
                parent_map.insert(right.borrow().val, node.clone());
                Self::build_parent_map(Some(right), parent_map);
            }
        }
    }
}