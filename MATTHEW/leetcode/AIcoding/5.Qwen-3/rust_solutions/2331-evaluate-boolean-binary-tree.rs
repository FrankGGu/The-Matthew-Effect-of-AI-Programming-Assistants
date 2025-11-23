impl Solution {

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn evaluate_tree(root: Option<Box<TreeNode>>) -> bool {
    if let Some(node) = root {
        if node.val == 0 {
            return false;
        } else if node.val == 1 {
            return true;
        } else {
            let left = evaluate_tree(node.left);
            let right = evaluate_tree(node.right);
            match node.val {
                2 => left || right,
                3 => left && right,
                _ => false,
            }
        }
    } else {
        false
    }
}
}