use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn minimal_exec_time(root: Option<Rc<RefCell<TreeNode>>>) -> f64 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>) -> (f64, f64) {
            if let Some(n) = node {
                let n = n.borrow();
                let (left_total, left_parallel) = dfs(n.left.clone());
                let (right_total, right_parallel) = dfs(n.right.clone());
                let total = left_total + right_total + n.val as f64;
                let parallel = if left_total > right_total {
                    left_parallel.max(left_total - right_total)
                } else {
                    right_parallel.max(right_total - left_total)
                };
                (total, parallel)
            } else {
                (0.0, 0.0)
            }
        }
        let (total, parallel) = dfs(root);
        total - parallel
    }
}