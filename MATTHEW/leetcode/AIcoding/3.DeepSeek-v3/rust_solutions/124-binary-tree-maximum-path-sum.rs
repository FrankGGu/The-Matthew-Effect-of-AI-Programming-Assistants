use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_path_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_sum = i32::MIN;
        Self::dfs(&root, &mut max_sum);
        max_sum
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> i32 {
        if let Some(n) = node {
            let n = n.borrow();
            let left = std::cmp::max(0, Self::dfs(&n.left, max_sum));
            let right = std::cmp::max(0, Self::dfs(&n.right, max_sum));
            *max_sum = std::cmp::max(*max_sum, n.val + left + right);
            n.val + std::cmp::max(left, right)
        } else {
            0
        }
    }
}