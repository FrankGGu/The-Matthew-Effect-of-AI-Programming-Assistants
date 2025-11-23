use std::cmp::Ordering;

#[derive(TreeNode)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl Solution {
    pub fn min_diff_in_bst(root: Option<Box<TreeNode>>) -> i32 {
        let mut values = vec![];
        Self::inorder_traversal(&root, &mut values);
        let mut min_diff = i32::MAX;
        for i in 1..values.len() {
            min_diff = min_diff.min(values[i] - values[i - 1]);
        }
        min_diff
    }

    fn inorder_traversal(node: &Option<Box<TreeNode>>, values: &mut Vec<i32>) {
        if let Some(n) = node {
            Self::inorder_traversal(&n.left, values);
            values.push(n.val);
            Self::inorder_traversal(&n.right, values);
        }
    }
}