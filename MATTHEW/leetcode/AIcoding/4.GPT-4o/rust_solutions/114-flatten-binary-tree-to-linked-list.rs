use crate::tree::TreeNode;

pub fn flatten(root: &mut Option<Box<TreeNode>>) {
    let mut curr = root.take();
    let mut prev = None;

    while let Some(mut node) = curr {
        curr = node.left.take();
        if let Some(p) = prev.as_mut() {
            p.right = Some(node);
        } else {
            *root = Some(node);
        }
        prev = Some(node);
        curr = curr.and_then(|n| n.right);
    }
}