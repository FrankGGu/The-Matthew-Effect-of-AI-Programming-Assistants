use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn sum_numbers(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, current_sum: i32, total_sum: &mut i32) {
            if let Some(n) = node {
                let node = n.borrow();
                let current_sum = current_sum * 10 + node.val;
                if node.left.is_none() && node.right.is_none() {
                    *total_sum += current_sum;
                } else {
                    dfs(node.left.clone(), current_sum, total_sum);
                    dfs(node.right.clone(), current_sum, total_sum);
                }
            }
        }
        let mut total_sum = 0;
        dfs(root, 0, &mut total_sum);
        total_sum
    }
}