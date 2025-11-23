use crate::utils::TreeNode;

impl Solution {
    pub fn evaluate_tree(root: Option<Box<TreeNode>>) -> bool {
        match root {
            Some(node) => {
                if node.val == 0 {
                    false
                } else if node.val == 1 {
                    true
                } else {
                    let left = Self::evaluate_tree(node.left);
                    let right = Self::evaluate_tree(node.right);
                    if node.val == 2 {
                        left || right
                    } else {
                        left && right
                    }
                }
            }
            None => false,
        }
    }
}