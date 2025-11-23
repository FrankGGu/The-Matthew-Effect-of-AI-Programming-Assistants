use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn sum_root_to_leaf(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, current_sum: i32, total_sum: &mut i32) {
            if let Some(n) = node {
                let n = n.borrow();
                let new_sum = (current_sum << 1) | n.val;
                if n.left.is_none() && n.right.is_none() {
                    *total_sum += new_sum;
                } else {
                    dfs(&n.left, new_sum, total_sum);
                    dfs(&n.right, new_sum, total_sum);
                }
            }
        }
        let mut total_sum = 0;
        dfs(&root, 0, &mut total_sum);
        total_sum
    }
}