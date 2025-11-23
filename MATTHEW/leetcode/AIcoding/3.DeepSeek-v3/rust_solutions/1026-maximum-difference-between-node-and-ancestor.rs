use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_ancestor_diff(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, mut min_val: i32, mut max_val: i32) -> i32 {
            if let Some(n) = node {
                let node = n.borrow();
                min_val = min_val.min(node.val);
                max_val = max_val.max(node.val);
                let left_diff = dfs(&node.left, min_val, max_val);
                let right_diff = dfs(&node.right, min_val, max_val);
                left_diff.max(right_diff).max(max_val - min_val)
            } else {
                0
            }
        }
        dfs(&root, root.as_ref().unwrap().borrow().val, root.as_ref().unwrap().borrow().val)
    }
}