use std::rc::Rc;
use std::cell::RefCell;

struct Solution;

impl Solution {
    pub fn good_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        Self::dfs(root, i32::MIN)
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_val_so_far: i32) -> i32 {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            let current_val = n.val;

            let mut count = 0;
            if current_val >= max_val_so_far {
                count += 1;
            }

            let new_max_val = current_val.max(max_val_so_far);

            count += Self::dfs(n.left.clone(), new_max_val);
            count += Self::dfs(n.right.clone(), new_max_val);

            count
        } else {
            0
        }
    }
}