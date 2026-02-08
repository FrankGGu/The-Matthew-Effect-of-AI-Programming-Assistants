use std::collections::HashMap;

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

pub fn subtree_inversion_sum(root: Option<Box<TreeNode>>, x: i32) -> i32 {
    let mut sum = 0;
    let mut stack = vec![root];

    while let Some(Some(node)) = stack.pop() {
        if node.val == x {
            sum += invert_subtree(&node);
        }
        if let Some(left) = node.left {
            stack.push(Some(left));
        }
        if let Some(right) = node.right {
            stack.push(Some(right));
        }
    }

    sum
}

fn invert_subtree(node: &Box<TreeNode>) -> i32 {
    let left_sum = if let Some(left) = &node.left {
        invert_subtree(left)
    } else {
        0
    };
    let right_sum = if let Some(right) = &node.right {
        invert_subtree(right)
    } else {
        0
    };

    left_sum + right_sum + node.val
}