#[derive(Debug, PartialEq, Eq)]
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

pub fn is_sub_structure(a: Option<Box<TreeNode>>, b: Option<Box<TreeNode>>) -> bool {
    fn is_same_tree(a: &Option<Box<TreeNode>>, b: &Option<Box<TreeNode>>) -> bool {
        match (a, b) {
            (None, None) => true,
            (Some(node_a), Some(node_b)) => {
                node_a.val == node_b.val
                    && is_same_tree(&node_a.left, &node_b.left)
                    && is_same_tree(&node_a.right, &node_b.right)
            }
            _ => false,
        }
    }

    match (a, b) {
        (None, _) => false,
        (Some(node_a), Some(node_b)) => {
            is_same_tree(&Some(node_a.clone()), &Some(node_b.clone()))
                || is_sub_structure(node_a.left, Some(node_b.clone()))
                || is_sub_structure(node_a.right, Some(node_b.clone()))
        }
    }
}