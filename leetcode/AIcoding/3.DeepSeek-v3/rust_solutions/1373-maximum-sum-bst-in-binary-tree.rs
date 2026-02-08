use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_sum_bst(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_sum = 0;
        Self::dfs(&root, &mut max_sum);
        max_sum
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> (i32, i32, i32, bool) {
        match node {
            None => (i32::MAX, i32::MIN, 0, true),
            Some(n) => {
                let n = n.borrow();
                let left = Self::dfs(&n.left, max_sum);
                let right = Self::dfs(&n.right, max_sum);
                let is_bst = left.3 && right.3 && n.val > left.1 && n.val < right.0;
                let sum = if is_bst {
                    let sum = left.2 + right.2 + n.val;
                    *max_sum = (*max_sum).max(sum);
                    sum
                } else {
                    0
                };
                let min_val = left.0.min(n.val);
                let max_val = right.1.max(n.val);
                (min_val, max_val, sum, is_bst)
            }
        }
    }
}