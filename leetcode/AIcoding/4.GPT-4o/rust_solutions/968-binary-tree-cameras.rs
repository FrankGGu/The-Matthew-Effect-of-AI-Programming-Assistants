use crate::TreeNode;

pub struct Solution;

impl Solution {
    pub fn min_camera_cover(root: Option<Box<TreeNode>>) -> i32 {
        fn dfs(node: Option<&Box<TreeNode>>, cameras: &mut i32) -> i32 {
            if let Some(n) = node {
                let left = dfs(n.left.as_ref(), cameras);
                let right = dfs(n.right.as_ref(), cameras);

                if left == 0 || right == 0 {
                    *cameras += 1;
                    return 2;
                }
                if left == 2 || right == 2 {
                    return 1;
                }
                return 0;
            }
            1
        }

        let mut cameras = 0;
        if dfs(root.as_ref(), &mut cameras) == 0 {
            cameras += 1;
        }
        cameras
    }
}