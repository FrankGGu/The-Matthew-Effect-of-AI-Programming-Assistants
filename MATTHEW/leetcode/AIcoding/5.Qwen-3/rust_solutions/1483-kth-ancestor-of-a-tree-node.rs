impl Solution {

use std::collections::VecDeque;

struct TreeAncestor {
    up: Vec<Vec<i32>>,
}

impl TreeAncestor {
    fn new(n: i32, mut parents: Vec<i32>) -> Self {
        let mut k = 0;
        while (1 << k) < n {
            k += 1;
        }
        let mut up = vec![vec![-1; n as usize]; k as usize];
        for i in 0..n as usize {
            up[0][i] = parents[i];
        }
        for j in 1..k {
            for i in 0..n as usize {
                if up[j - 1][i] != -1 {
                    up[j][i] = up[j - 1][up[j - 1][i] as usize];
                }
            }
        }
        TreeAncestor { up }
    }

    fn get_kth_ancestor(&self, mut node: i32, k: i32) -> i32 {
        let mut depth = k;
        for j in 0..self.up.len() {
            if depth & 1 == 1 {
                node = self.up[j][node as usize];
                if node == -1 {
                    return -1;
                }
            }
            depth >>= 1;
        }
        node
    }
}

struct Solution;

impl Solution {
    fn kth_ancestor(mut root: Option<Box<TreeNode>>, k: i32) -> i32 {
        let mut nodes = Vec::new();
        let mut queue = VecDeque::new();
        queue.push_back(root);
        while let Some(Some(node)) = queue.pop_front() {
            nodes.push(node.val);
            queue.push_back(node.left);
            queue.push_back(node.right);
        }
        let n = nodes.len() as i32;
        let mut parents = vec![-1; n as usize];
        for i in 0..n as usize {
            if i > 0 {
                let parent_idx = (i - 1) / 2;
                parents[i] = nodes[parent_idx];
            }
        }
        let tree_ancestor = TreeAncestor::new(n, parents);
        tree_ancestor.get_kth_ancestor(nodes[0], k)
    }
}

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
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
}