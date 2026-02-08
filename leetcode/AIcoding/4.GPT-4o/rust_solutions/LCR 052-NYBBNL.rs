use crate::utils::TreeNode;

impl Solution {
    pub fn increasing_bst(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
        let mut result = Vec::new();
        Self::inorder_traversal(&root, &mut result);
        let mut dummy = Box::new(TreeNode::new(0));
        let mut current = &mut dummy;

        for val in result {
            current.right = Some(Box::new(TreeNode::new(val)));
            current = current.right.as_mut().unwrap();
        }

        dummy.right
    }

    fn inorder_traversal(node: &Option<Box<TreeNode>>, result: &mut Vec<i32>) {
        if let Some(n) = node {
            Self::inorder_traversal(&n.left, result);
            result.push(n.val);
            Self::inorder_traversal(&n.right, result);
        }
    }
}