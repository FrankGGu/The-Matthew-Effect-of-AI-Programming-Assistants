use crate::models::TreeNode;

pub fn prune_tree(root: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    if root.is_none() {
        return None;
    }

    let mut root = root;
    let left = prune_tree(root.as_mut().unwrap().left.take());
    let right = prune_tree(root.as_mut().unwrap().right.take());

    root.as_mut().unwrap().left = left;
    root.as_mut().unwrap().right = right;

    if root.as_ref().unwrap().val == 0 && root.as_ref().unwrap().left.is_none() && root.as_ref().unwrap().right.is_none() {
        return None;
    }

    root
}