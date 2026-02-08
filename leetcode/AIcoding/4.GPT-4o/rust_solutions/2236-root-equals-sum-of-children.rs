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

pub fn check_tree(root: Option<Box<TreeNode>>) -> bool {
    if let Some(node) = root {
        let left_val = node.left.as_ref().map_or(0, |n| n.val);
        let right_val = node.right.as_ref().map_or(0, |n| n.val);
        return node.val == left_val + right_val;
    }
    false
}