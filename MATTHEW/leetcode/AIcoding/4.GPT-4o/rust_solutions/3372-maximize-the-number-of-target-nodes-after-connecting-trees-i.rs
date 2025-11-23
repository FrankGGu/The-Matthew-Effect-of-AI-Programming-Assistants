use std::collections::HashSet;

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

pub fn maximize_the_number_of_target_nodes(root: Option<Box<TreeNode>>, target: i32) -> i32 {
    let mut targets = HashSet::new();
    let mut count = 0;

    fn dfs(node: Option<&Box<TreeNode>>, target: i32, targets: &mut HashSet<i32>, count: &mut i32) {
        if let Some(n) = node {
            if n.val == target {
                *count += 1;
                targets.insert(target);
            }
            dfs(n.left.as_ref(), target, targets, count);
            dfs(n.right.as_ref(), target, targets, count);
        }
    }

    dfs(root.as_ref(), target, &mut targets, &mut count);

    count
}