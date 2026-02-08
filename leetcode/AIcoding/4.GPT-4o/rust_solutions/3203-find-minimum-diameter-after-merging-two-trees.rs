use std::collections::VecDeque;

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

pub fn find_diameter(root: Option<Box<TreeNode>>) -> i32 {
    let mut max_diameter = 0;

    fn depth(node: &Option<Box<TreeNode>>, max_diameter: &mut i32) -> i32 {
        if let Some(n) = node {
            let left_depth = depth(&n.left, max_diameter);
            let right_depth = depth(&n.right, max_diameter);
            *max_diameter = (*max_diameter).max(left_depth + right_depth);
            1 + left_depth.max(right_depth)
        } else {
            0
        }
    }

    depth(&root, &mut max_diameter);
    max_diameter
}

pub fn find_minimum_diameter(root1: Option<Box<TreeNode>>, root2: Option<Box<TreeNode>>, m: i32) -> i32 {
    let mut diam1 = find_diameter(root1);
    let mut diam2 = find_diameter(root2);
    let min_diameter = diam1.min(diam2) - m;
    min_diameter.max(0)
}