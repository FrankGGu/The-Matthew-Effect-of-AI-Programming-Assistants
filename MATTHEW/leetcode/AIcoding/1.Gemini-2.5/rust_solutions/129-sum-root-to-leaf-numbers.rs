use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sum_numbers(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut total_sum = 0;
        Self::dfs(root, 0, &mut total_sum);
        total_sum
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, current_path_num: i32, total_sum: &mut i32) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            let new_path_num = current_path_num * 10 + n.val;

            if n.left.is_none() && n.right.is_none() {
                *total_sum += new_path_num;
            } else {
                Self::dfs(n.left.clone(), new_path_num, total_sum);
                Self::dfs(n.right.clone(), new_path_num, total_sum);
            }
        }
    }
}