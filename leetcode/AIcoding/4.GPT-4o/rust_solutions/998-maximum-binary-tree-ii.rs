use crate::TreeNode;

pub fn insert_into_max_tree(root: Option<Box<TreeNode>>, val: i32) -> Option<Box<TreeNode>> {
    let mut node = TreeNode::new(val);
    let mut cur = root;

    while let Some(mut r) = cur {
        if r.val < node.val {
            node.left = Some(r);
            return Some(Box::new(node));
        }
        cur = r.right.take();
        node = TreeNode::new(r.val);
        node.left = r.left;
        node.right = r.right;
    }

    Some(Box::new(node))
}