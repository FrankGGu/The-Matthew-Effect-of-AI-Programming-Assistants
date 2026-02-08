#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn lowest_common_ancestor(root: Option<Box<TreeNode>>, p: Option<Box<TreeNode>>, q: Option<Box<TreeNode>>) -> Option<Box<TreeNode>> {
    let (p, q) = (p.as_ref(), q.as_ref());
    if root.is_none() || p.is_none() || q.is_none() {
        return None;
    }
    let root = root.unwrap();
    if root.val == p.unwrap().val || root.val == q.unwrap().val {
        return Some(root);
    }
    let left = lowest_common_ancestor(root.left, p.map(|x| *x), q.map(|x| *x));
    let right = lowest_common_ancestor(root.right, p.map(|x| *x), q.map(|x| *x));
    if left.is_some() && right.is_some() {
        return Some(root);
    }
    left.or(right)
}