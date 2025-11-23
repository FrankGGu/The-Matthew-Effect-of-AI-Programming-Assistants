use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn deepest_leaves_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_depth = 0;
        let mut sum = 0;

        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, depth: i32, max_depth: &mut i32, sum: &mut i32) {
            if let Some(node) = node {
                let node_ref = node.borrow();
                if node_ref.left.is_none() && node_ref.right.is_none() {
                    if depth > *max_depth {
                        *max_depth = depth;
                        *sum = node_ref.val;
                    } else if depth == *max_depth {
                        *sum += node_ref.val;
                    }
                } else {
                    dfs(node_ref.left.clone(), depth + 1, max_depth, sum);
                    dfs(node_ref.right.clone(), depth + 1, max_depth, sum);
                }
            }
        }

        dfs(root, 0, &mut max_depth, &mut sum);
        sum
    }
}