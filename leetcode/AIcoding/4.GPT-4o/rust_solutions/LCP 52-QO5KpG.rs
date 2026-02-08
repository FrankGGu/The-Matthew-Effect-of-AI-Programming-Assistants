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

pub fn bst_color(root: Option<Box<TreeNode>>, target: i32) -> Vec<i32> {
    let mut result = Vec::new();
    let mut map = HashMap::new();
    let mut stack = vec![root];

    while let Some(node) = stack.pop() {
        if let Some(n) = node {
            if n.val <= target {
                result.push(n.val);
            }
            stack.push(n.right);
            stack.push(n.left);
        }
    }

    result.sort();
    result
}