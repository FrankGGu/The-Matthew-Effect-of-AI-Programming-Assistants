use std::collections::BinaryHeap;

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn kth_largest_level_sum(root: Option<Box<TreeNode>>, k: i32) -> i32 {
    let mut level_sums = Vec::new();
    let mut queue = vec![root];

    while !queue.is_empty() {
        let mut next_queue = Vec::new();
        let mut level_sum = 0;

        for node in queue {
            if let Some(n) = node {
                level_sum += n.val;
                next_queue.push(n.left);
                next_queue.push(n.right);
            }
        }

        if level_sum > 0 {
            level_sums.push(level_sum);
        }

        queue = next_queue.into_iter().filter(|x| x.is_some()).collect();
    }

    let mut heap = BinaryHeap::new();
    for sum in level_sums {
        heap.push(sum);
        if heap.len() > k as usize {
            heap.pop();
        }
    }

    if let Some(kth_sum) = heap.pop() {
        return kth_sum;
    }

    -1
}