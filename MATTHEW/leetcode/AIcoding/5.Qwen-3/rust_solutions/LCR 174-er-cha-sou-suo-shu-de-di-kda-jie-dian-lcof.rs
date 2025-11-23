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

pub fn search_bst(root: Option<Box<TreeNode>>, val: i32) -> Option<Box<TreeNode>> {
    let mut current = root;
    while let Some(node) = current {
        if node.val == val {
            return Some(node);
        } else if node.val < val {
            current = node.right;
        } else {
            current = node.left;
        }
    }
    None
}
}