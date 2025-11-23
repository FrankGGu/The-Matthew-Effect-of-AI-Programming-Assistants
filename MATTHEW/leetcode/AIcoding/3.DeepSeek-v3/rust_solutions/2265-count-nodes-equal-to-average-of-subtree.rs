use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn average_of_subtree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut count = 0;
        Self::dfs(&root, &mut count);
        count
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, count: &mut i32) -> (i32, i32) {
        if let Some(n) = node {
            let n = n.borrow();
            let (left_sum, left_count) = Self::dfs(&n.left, count);
            let (right_sum, right_count) = Self::dfs(&n.right, count);
            let total_sum = left_sum + right_sum + n.val;
            let total_count = left_count + right_count + 1;
            if total_sum / total_count == n.val {
                *count += 1;
            }
            (total_sum, total_count)
        } else {
            (0, 0)
        }
    }
}