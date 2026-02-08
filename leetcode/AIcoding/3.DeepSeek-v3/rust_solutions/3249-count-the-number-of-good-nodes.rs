use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn good_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_val: i32, count: &mut i32) {
            if let Some(n) = node {
                let n_ref = n.borrow();
                let current_val = n_ref.val;
                if current_val >= max_val {
                    *count += 1;
                }
                let new_max = max_val.max(current_val);
                dfs(n_ref.left.clone(), new_max, count);
                dfs(n_ref.right.clone(), new_max, count);
            }
        }

        let mut count = 0;
        dfs(root, i32::MIN, &mut count);
        count
    }
}