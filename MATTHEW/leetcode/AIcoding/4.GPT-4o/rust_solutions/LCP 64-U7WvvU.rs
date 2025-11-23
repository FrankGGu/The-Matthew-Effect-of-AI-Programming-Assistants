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

pub fn min_camera_cover(root: Option<Box<TreeNode>>) -> i32 {
    let mut cameras = 0;
    let mut covered = HashSet::new();

    fn dfs(node: &Option<Box<TreeNode>>, cameras: &mut i32, covered: &mut HashSet<*const TreeNode>) -> bool {
        if let Some(n) = node {
            let left = dfs(&n.left, cameras, covered);
            let right = dfs(&n.right, cameras, covered);

            if !left || !right {
                *cameras += 1;
                covered.insert(&**n as *const _);
                return true;
            }

            return covered.contains(&(n as *const _)) || left || right;
        }
        false
    }

    if !dfs(&root, &mut cameras, &mut covered) {
        cameras += 1;
    }
    cameras
}