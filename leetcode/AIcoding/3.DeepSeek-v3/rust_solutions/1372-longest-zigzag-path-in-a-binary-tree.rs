use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn longest_zig_zag(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, is_left: bool, length: i32, max_length: &mut i32) {
            if let Some(n) = node {
                let n = n.borrow();
                *max_length = (*max_length).max(length);
                if is_left {
                    dfs(&n.right, false, length + 1, max_length);
                    dfs(&n.left, true, 1, max_length);
                } else {
                    dfs(&n.left, true, length + 1, max_length);
                    dfs(&n.right, false, 1, max_length);
                }
            }
        }

        let mut max_length = 0;
        dfs(&root, true, 0, &mut max_length);
        dfs(&root, false, 0, &mut max_length);
        max_length
    }
}