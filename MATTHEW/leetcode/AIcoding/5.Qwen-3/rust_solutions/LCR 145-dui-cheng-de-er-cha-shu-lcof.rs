impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn is_symmetric(root: Option<Box<TreeNode>>) -> bool {
    fn is_same(left: Option<Box<TreeNode>>, right: Option<Box<TreeNode>>) -> bool {
        match (left, right) {
            (None, None) => true,
            (Some(l), Some(r)) => l.val == r.val && is_same(l.left, r.right) && is_same(l.right, r.left),
            _ => false,
        }
    }

    is_same(root.clone(), root)
}
}