use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn sum_numbers(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, current_sum: i32, total: &mut i32) {
            if let Some(n) = node {
                let n = n.borrow();
                let new_sum = current_sum * 10 + n.val;
                if n.left.is_none() && n.right.is_none() {
                    *total += new_sum;
                } else {
                    dfs(&n.left, new_sum, total);
                    dfs(&n.right, new_sum, total);
                }
            }
        }
        let mut total = 0;
        dfs(&root, 0, &mut total);
        total
    }
}