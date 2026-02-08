use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn min_camera_cover(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>) -> (i32, i32, i32) {
            if let Some(n) = node {
                let left = dfs(&n.borrow().left);
                let right = dfs(&n.borrow().right);
                let min_left = left.0.min(left.1);
                let min_right = right.0.min(right.1);
                let d0 = left.1 + right.1;
                let d1 = (left.2 + min_right).min(right.2 + min_left);
                let d2 = 1 + left.0.min(left.1).min(left.2) + right.0.min(right.1).min(right.2);
                (d0, d1, d2)
            } else {
                (0, 0, std::i32::MAX / 2)
            }
        }
        let (d0, d1, d2) = dfs(&root);
        d1.min(d2)
    }
}