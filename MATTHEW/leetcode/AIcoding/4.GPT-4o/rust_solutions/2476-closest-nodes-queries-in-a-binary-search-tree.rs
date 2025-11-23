use std::collections::VecDeque;

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

struct BSTIterator {
    stack: Vec<Box<TreeNode>>,
}

impl BSTIterator {
    fn new(root: Option<Box<TreeNode>>) -> Self {
        let mut stack = Vec::new();
        let mut current = root;
        while let Some(node) = current {
            stack.push(node);
            current = node.left;
        }
        BSTIterator { stack }
    }

    fn next(&mut self) -> Option<i32> {
        if let Some(mut node) = self.stack.pop() {
            let value = node.val;
            let right = node.right.take();
            let mut current = right;
            while let Some(n) = current {
                self.stack.push(n);
                current = n.left;
            }
            return Some(value);
        }
        None
    }

    fn has_next(&self) -> bool {
        !self.stack.is_empty()
    }
}

impl Solution {
    pub fn closest_nodes(root: Option<Box<TreeNode>>, queries: Vec<i32>) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut iter = BSTIterator::new(root);
        let mut sorted_values = Vec::new();

        while iter.has_next() {
            if let Some(val) = iter.next() {
                sorted_values.push(val);
            }
        }

        for query in queries {
            let mut left = -1;
            let mut right = -1;
            let mut low = 0;
            let mut high = sorted_values.len() as i32 - 1;

            while low <= high {
                let mid = low + (high - low) / 2;
                if sorted_values[mid as usize] < query {
                    left = sorted_values[mid as usize];
                    low = mid + 1;
                } else {
                    right = sorted_values[mid as usize];
                    high = mid - 1;
                }
            }

            result.push(vec![left, right]);
        }

        result
    }
}