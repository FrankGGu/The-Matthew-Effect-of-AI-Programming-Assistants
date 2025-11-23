#[derive(TreeNode)]
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

pub fn search_bst(root: Option<Box<TreeNode>>, val: i32) -> Option<Box<TreeNode>> {
    match root {
        Some(node) => {
            if node.val == val {
                Some(node)
            } else if val < node.val {
                search_bst(node.left, val)
            } else {
                search_bst(node.right, val)
            }
        }
        None => None,
    }
}