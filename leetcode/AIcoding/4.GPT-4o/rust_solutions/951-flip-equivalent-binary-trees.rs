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

pub fn flip_equiv(root1: Option<Box<TreeNode>>, root2: Option<Box<TreeNode>>) -> bool {
    match (root1, root2) {
        (None, None) => true,
        (Some(n1), Some(n2)) if n1.val == n2.val => {
            flip_equiv(n1.left, n2.left) && flip_equiv(n1.right, n2.right) ||
            flip_equiv(n1.left, n2.right) && flip_equiv(n1.right, n2.left)
        },
        _ => false,
    }
}