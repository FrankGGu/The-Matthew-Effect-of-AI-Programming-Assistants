impl Solution {

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

pub fn preorder_traversal(root: Option<Box<TreeNode>>) -> Vec<i32> {
    let mut result = Vec::new();
    let mut stack = Vec::new();

    if let Some(node) = root {
        stack.push(node);
    }

    while let Some(mut node) = stack.pop() {
        result.push(node.val);
        if let Some(right) = node.right {
            stack.push(right);
        }
        if let Some(left) = node.left {
            stack.push(left);
        }
    }

    result
}
}