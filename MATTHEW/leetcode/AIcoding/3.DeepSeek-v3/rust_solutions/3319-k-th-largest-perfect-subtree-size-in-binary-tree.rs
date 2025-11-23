use std::rc::Rc;
use std::cell::RefCell;
use std::collections::BinaryHeap;

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

struct SubtreeInfo {
    size: i32,
    is_perfect: bool,
    depth: i32,
}

impl Solution {
    pub fn kth_largest_perfect_subtree_size(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        Self::dfs(&root, &mut heap);
        if heap.len() < k as usize {
            -1
        } else {
            let mut res = -1;
            for _ in 0..k {
                res = heap.pop().unwrap();
            }
            res
        }
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, heap: &mut BinaryHeap<i32>) -> SubtreeInfo {
        match node {
            None => SubtreeInfo {
                size: 0,
                is_perfect: true,
                depth: 0,
            },
            Some(n) => {
                let node_ref = n.borrow();
                let left_info = Self::dfs(&node_ref.left, heap);
                let right_info = Self::dfs(&node_ref.right, heap);
                let is_perfect = left_info.is_perfect && right_info.is_perfect && left_info.depth == right_info.depth;
                let size = left_info.size + right_info.size + 1;
                let depth = left_info.depth.max(right_info.depth) + 1;
                if is_perfect {
                    heap.push(size);
                }
                SubtreeInfo {
                    size,
                    is_perfect,
                    depth,
                }
            }
        }
    }
}