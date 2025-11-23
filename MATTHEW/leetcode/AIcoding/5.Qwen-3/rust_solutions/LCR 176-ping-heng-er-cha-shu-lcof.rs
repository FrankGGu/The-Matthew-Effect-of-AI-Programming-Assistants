impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

pub fn is_balanced(root: Option<Box<TreeNode>>) -> bool {
    fn height(node: &Option<Box<TreeNode>>) -> i32 {
        match node {
            None => 0,
            Some(n) => {
                let left = height(&n.left);
                let right = height(&n.right);
                if left == -1 || right == -1 || (left - right).abs() > 1 {
                    -1
                } else {
                    1 + std::cmp::max(left, right)
                }
            }
        }
    }

    height(&root) != -1
}
}