#[derive(Clone, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn has_path_sum(root: Option<Box<TreeNode>>, sum: i32) -> bool {
    if let Some(node) = root {
        let node = node.as_ref();
        if node.left.is_none() && node.right.is_none() {
            return node.val == sum;
        }
        let new_sum = sum - node.val;
        has_path_sum(node.left.clone(), new_sum) || has_path_sum(node.right.clone(), new_sum)
    } else {
        sum == 0
    }
}