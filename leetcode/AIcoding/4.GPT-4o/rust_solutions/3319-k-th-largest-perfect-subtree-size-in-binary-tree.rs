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

pub fn kth_largest_perfect_subtree_size(root: Option<Box<TreeNode>>, k: i32) -> i32 {
    let mut sizes = Vec::new();
    fn dfs(node: &Option<Box<TreeNode>>, sizes: &mut Vec<i32>) -> i32 {
        if let Some(n) = node {
            let left_size = dfs(&n.left, sizes);
            let right_size = dfs(&n.right, sizes);
            let current_size = left_size + right_size + 1;
            if left_size == right_size {
                sizes.push(current_size);
            }
            return current_size;
        }
        0
    }
    dfs(&root, &mut sizes);
    let mut heap = BinaryHeap::new();
    for size in sizes {
        heap.push(size);
        if heap.len() > k as usize {
            heap.pop();
        }
    }
    heap.pop().unwrap_or(0)
}