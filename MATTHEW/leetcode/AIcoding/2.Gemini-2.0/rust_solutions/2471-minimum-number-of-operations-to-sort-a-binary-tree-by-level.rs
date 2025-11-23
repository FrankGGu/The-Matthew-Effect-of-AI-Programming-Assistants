use std::cell::RefCell;
use std::collections::VecDeque;
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
    pub fn minimum_operations(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut queue = VecDeque::new();
        if let Some(r) = root {
            queue.push_back(r);
        }

        let mut operations = 0;

        while !queue.is_empty() {
            let level_size = queue.len();
            let mut level_values = Vec::new();

            for _ in 0..level_size {
                if let Some(node) = queue.pop_front() {
                    let node_ref = node.borrow();
                    level_values.push(node_ref.val);

                    if let Some(left) = &node_ref.left {
                        queue.push_back(Rc::clone(left));
                    }
                    if let Some(right) = &node_ref.right {
                        queue.push_back(Rc::clone(right));
                    }
                }
            }

            operations += Self::min_swaps_to_sort(&mut level_values);
        }

        operations
    }

    fn min_swaps_to_sort(arr: &mut Vec<i32>) -> i32 {
        let mut sorted_arr = arr.clone();
        sorted_arr.sort();

        let mut pos = std::collections::HashMap::new();
        for (i, &val) in arr.iter().enumerate() {
            pos.insert(val, i);
        }

        let mut swaps = 0;
        let mut visited = vec![false; arr.len()];

        for i in 0..arr.len() {
            if visited[i] || arr[i] == sorted_arr[i] {
                continue;
            }

            let mut cycle_size = 0;
            let mut j = i;
            while !visited[j] {
                visited[j] = true;
                j = *pos.get(&sorted_arr[j]).unwrap();
                cycle_size += 1;
            }

            if cycle_size > 0 {
                swaps += cycle_size - 1;
            }
        }

        swaps as i32
    }
}

struct Solution;