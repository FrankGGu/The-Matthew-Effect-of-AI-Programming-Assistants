use crate::TreeNode;

pub fn is_unival_tree(root: Option<Box<TreeNode>>) -> bool {
    fn helper(node: &Option<Box<TreeNode>>, value: i32) -> bool {
        match node {
            Some(n) => n.val == value && helper(&n.left, value) && helper(&n.right, value),
            None => true,
        }
    }

    match root {
        Some(ref n) => helper(&root, n.val),
        None => true,
    }
}