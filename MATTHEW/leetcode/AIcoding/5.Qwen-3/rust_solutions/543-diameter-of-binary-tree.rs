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

pub fn diameter_of_binary_tree(root: Option<Box<TreeNode>>) -> i32 {
    let mut max_diameter = 0;

    fn dfs(node: Option<Box<TreeNode>>, max_diameter: &mut i32) -> i32 {
        if let Some(n) = node {
            let left_depth = dfs(n.left, max_diameter);
            let right_depth = dfs(n.right, max_diameter);
            *max_diameter = std::cmp::max(*max_diameter, left_depth + right_depth);
            std::cmp::max(left_depth, right_depth) + 1
        } else {
            0
        }
    }

    dfs(root, &mut max_diameter);
    max_diameter
}