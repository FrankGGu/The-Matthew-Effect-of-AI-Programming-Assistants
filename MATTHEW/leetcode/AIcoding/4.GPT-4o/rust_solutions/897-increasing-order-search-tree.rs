use crate::util::TreeNode;

pub fn increasing_bst(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    let mut nodes = Vec::new();
    inorder_traversal(&root, &mut nodes);

    let mut dummy = Box::new(TreeNode::new(0));
    let mut current = &mut dummy;

    for node in nodes {
        current.right = Some(Box::new(TreeNode::new(node.val)));
        current = current.right.as_mut().unwrap();
    }

    dummy.right
}

fn inorder_traversal(node: &Option<Box<TreeNode>>, nodes: &mut Vec<&Box<TreeNode>>) {
    if let Some(n) = node {
        inorder_traversal(&n.left, nodes);
        nodes.push(n);
        inorder_traversal(&n.right, nodes);
    }
}