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

pub fn flatten(root: &mut Option<Box<TreeNode>>) {
    let mut stack = Vec::new();
    if let Some(mut node) = root.take() {
        stack.push(node);
        while let Some(mut current) = stack.pop() {
            if let Some(right) = current.right.take() {
                stack.push(right);
            }
            if let Some(left) = current.left.take() {
                stack.push(left);
            }
            if let Some(mut next) = stack.last_mut() {
                current.right = Some(next.take());
            }
            *root = Some(current);
        }
    }
}
}