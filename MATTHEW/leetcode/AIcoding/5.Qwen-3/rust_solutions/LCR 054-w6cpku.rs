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

pub fn convert_bst(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    let mut sum = 0;
    convert_bst_helper(&mut sum, root)
}

fn convert_bst_helper(sum: &mut i32, root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    if let Some(mut node) = root {
        convert_bst_helper(sum, node.right.take());
        *sum += node.val;
        node.val = *sum;
        convert_bst_helper(sum, node.left.take());
        Some(node)
    } else {
        None
    }
}
}