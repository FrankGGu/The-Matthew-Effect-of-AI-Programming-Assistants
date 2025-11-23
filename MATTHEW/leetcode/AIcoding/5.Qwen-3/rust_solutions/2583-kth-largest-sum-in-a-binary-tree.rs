impl Solution {

use std::collections::BinaryHeap;
use std::collections::VecDeque;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn kth_largest_sum(root: Option<Box<TreeNode>>, k: i32) -> i32 {
    let mut sums = Vec::new();
    let mut queue = VecDeque::new();

    if let Some(node) = root {
        queue.push_back(node);
    }

    while !queue.is_empty() {
        let level_size = queue.len();
        let mut level_sum = 0;

        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                level_sum += node.val;

                if let Some(left) = node.left {
                    queue.push_back(left);
                }

                if let Some(right) = node.right {
                    queue.push_back(right);
                }
            }
        }

        sums.push(level_sum);
    }

    let mut heap = BinaryHeap::new();

    for sum in sums {
        heap.push(sum);
    }

    let mut result = 0;

    for _ in 0..k {
        if let Some(val) = heap.pop() {
            result = val;
        } else {
            return -1;
        }
    }

    result
}
}