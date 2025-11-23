use std::rc::Rc;
use std::cell::RefCell;
use std::collections::VecDeque;

struct Solution;

impl Solution {
    pub fn minimum_operations(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        if root.is_none() {
            return 0;
        }

        let mut total_swaps = 0;
        let mut q: VecDeque<Rc<RefCell<TreeNode>>> = VecDeque::new();
        q.push_back(root.unwrap());

        while !q.is_empty() {
            let level_size = q.len();
            let mut current_level_values: Vec<i32> = Vec::with_capacity(level_size);

            for _ in 0..level_size {
                let node_rc = q.pop_front().unwrap();
                let node = node_rc.borrow();
                current_level_values.push(node.val);

                if let Some(left_child) = node.left.clone() {
                    q.push_back(left_child);
                }
                if let Some(right_child) = node.right.clone() {
                    q.push_back(right_child);
                }
            }

            if current_level_values.len() > 1 {
                total_swaps += Self::min_swaps_to_sort(&current_level_values);
            }
        }

        total_swaps
    }

    fn min_swaps_to_sort(arr: &[i32]) -> i32 {
        let n = arr.len();
        if n <= 1 {
            return 0;
        }

        let mut pairs: Vec<(i32, usize)> = Vec::with_capacity(n);
        for (i, &val) in arr.iter().enumerate() {
            pairs.push((val, i));
        }

        pairs.sort_by_key(|&(val, _)| val);

        let mut visited: Vec<bool> = vec![false; n];
        let mut level_swaps = 0;

        for i in 0..n {
            if visited[i] || pairs[i].1 == i {
                continue;
            }

            let mut cycle_len = 0;
            let mut j = i;
            while !visited[j] {
                visited[j] = true;
                j = pairs[j].1;
                cycle_len += 1;
            }
            level_swaps += cycle_len - 1;
        }

        level_swaps as i32
    }
}