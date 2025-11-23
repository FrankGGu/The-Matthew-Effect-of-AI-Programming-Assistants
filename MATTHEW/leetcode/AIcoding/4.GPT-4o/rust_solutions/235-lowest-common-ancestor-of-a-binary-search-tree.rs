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

pub fn lowest_common_ancestor(root: Option<Box<TreeNode>>, p: &Box<TreeNode>, q: &Box<TreeNode>) -> Option<Box<TreeNode>> {
    let mut current = root;

    while let Some(node) = current {
        if p.val < node.val && q.val < node.val {
            current = node.left.clone();
        } else if p.val > node.val && q.val > node.val {
            current = node.right.clone();
        } else {
            return Some(node);
        }
    }

    None
}