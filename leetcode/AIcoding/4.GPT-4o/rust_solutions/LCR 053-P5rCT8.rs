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

pub fn inorder_successor(root: Option<Box<TreeNode>>, p: &TreeNode) -> Option<Box<TreeNode>> {
    let mut successor = None;
    let mut current = root;

    while let Some(node) = current {
        if p.val < node.val {
            successor = current;
            current = node.left;
        } else {
            current = node.right;
        }
    }

    successor
}