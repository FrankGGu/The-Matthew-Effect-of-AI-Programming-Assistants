#[derive(Box)]
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

pub fn insert_into_bst(root: Option<Box<TreeNode>>, val: i32) -> Option<Box<TreeNode>> {
    match root {
        None => Some(Box::new(TreeNode::new(val))),
        Some(mut node) => {
            if val < node.val {
                node.left = insert_into_bst(node.left, val);
            } else {
                node.right = insert_into_bst(node.right, val);
            }
            Some(node)
        }
    }
}