use std::collections::{VecDeque, HashMap};
use std::cmp::Ordering;

impl Solution {
    pub fn minimum_operations(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if root.is_none() {
            return 0;
        }
        let mut queue = VecDeque::new();
        queue.push_back(root.unwrap());
        let mut res = 0;

        while !queue.is_empty() {
            let len = queue.len();
            let mut level = Vec::new();
            let mut idx = 0;
            let mut pos_map = HashMap::new();

            for _ in 0..len {
                let node = queue.pop_front().unwrap();
                let node = node.borrow();
                level.push(node.val);
                pos_map.insert(node.val, idx);
                idx += 1;
                if node.left.is_some() {
                    queue.push_back(node.left.as_ref().unwrap().clone());
                }
                if node.right.is_some() {
                    queue.push_back(node.right.as_ref().unwrap().clone());
                }
            }

            let mut sorted = level.clone();
            sorted.sort();
            let mut visited = vec![false; level.len()];

            for i in 0..level.len() {
                if !visited[i] && level[i] != sorted[i] {
                    let mut j = i;
                    let mut cycle_size = 0;

                    while !visited[j] {
                        visited[j] = true;
                        j = pos_map[&sorted[j]];
                        cycle_size += 1;
                    }

                    res += cycle_size - 1;
                }
            }
        }

        res
    }
}