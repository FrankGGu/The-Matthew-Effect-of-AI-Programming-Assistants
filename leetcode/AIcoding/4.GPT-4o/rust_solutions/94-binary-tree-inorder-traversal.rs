use crate::util::TreeNode;

impl Solution {
    pub fn inorder_traversal(root: Option<Box<TreeNode>>) -> Vec<i32> {
        let mut result = Vec::new();
        Self::traverse(&root, &mut result);
        result
    }

    fn traverse(node: &Option<Box<TreeNode>>, result: &mut Vec<i32>) {
        if let Some(n) = node {
            Self::traverse(&n.left, result);
            result.push(n.val);
            Self::traverse(&n.right, result);
        }
    }
}