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

pub struct Solution {}

impl Solution {
    pub fn count_nodes(root: Option<Box<TreeNode>>) -> i32 {
        if root.is_none() {
            return 0;
        }

        let mut left_depth = 0;
        let mut node = root.as_ref().unwrap();
        while let Some(left) = &node.left {
            left_depth += 1;
            node = left;
        }

        let mut right_depth = 0;
        let mut node = root.as_ref().unwrap();
        while let Some(right) = &node.right {
            right_depth += 1;
            node = right;
        }

        if left_depth == right_depth {
            return (1 << (left_depth + 1)) - 1;
        }

        1 + Self::count_nodes(root.as_ref().unwrap().left.clone()) + Self::count_nodes(root.as_ref().unwrap().right.clone())
    }
}
}