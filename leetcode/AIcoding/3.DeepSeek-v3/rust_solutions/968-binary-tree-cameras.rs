use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
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

enum Status {
    Covered,
    NotCovered,
    HasCamera,
}

impl Solution {
    pub fn min_camera_cover(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut cameras = 0;
        match Self::dfs(&root, &mut cameras) {
            Status::NotCovered => cameras + 1,
            _ => cameras,
        }
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>, cameras: &mut i32) -> Status {
        if let Some(n) = node {
            let n = n.borrow();
            let left = Self::dfs(&n.left, cameras);
            let right = Self::dfs(&n.right, cameras);

            if left == Status::NotCovered || right == Status::NotCovered {
                *cameras += 1;
                Status::HasCamera
            } else if left == Status::HasCamera || right == Status::HasCamera {
                Status::Covered
            } else {
                Status::NotCovered
            }
        } else {
            Status::Covered
        }
    }
}