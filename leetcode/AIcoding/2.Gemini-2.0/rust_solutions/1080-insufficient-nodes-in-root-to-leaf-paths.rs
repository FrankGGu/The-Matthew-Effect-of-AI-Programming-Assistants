use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sufficient_subset(root: Option<Rc<RefCell<TreeNode>>>, limit: i32) -> Option<Rc<RefCell<TreeNode>>> {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, current_sum: i32, limit: i32) -> bool {
            if let Some(n) = node {
                let mut node_ref = n.borrow_mut();
                if node_ref.left.is_none() && node_ref.right.is_none() {
                    return current_sum + node_ref.val >= limit;
                }

                let left_sufficient = dfs(&node_ref.left, current_sum + node_ref.val, limit);
                let right_sufficient = dfs(&node_ref.right, current_sum + node_ref.val, limit);

                if !left_sufficient {
                    node_ref.left = None;
                }
                if !right_sufficient {
                    node_ref.right = None;
                }

                return left_sufficient || right_sufficient;
            }
            false
        }

        if dfs(&root, 0, limit) {
            root
        } else {
            None
        }
    }
}