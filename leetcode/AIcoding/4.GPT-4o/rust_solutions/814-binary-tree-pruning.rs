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

pub fn prune_tree(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    fn should_prune(node: Option<&Box<TreeNode>>) -> bool {
        if let Some(n) = node {
            let left = should_prune(n.left.as_ref());
            let right = should_prune(n.right.as_ref());
            if left {
                n.left = None;
            }
            if right {
                n.right = None;
            }
            n.val == 0 && left && right
        } else {
            true
        }
    }

    if should_prune(root.as_ref()) {
        None
    } else {
        root
    }
}