use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sum_even_grandparent(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut total_sum = 0;
        Self::dfs(root, -1, -1, &mut total_sum);
        total_sum
    }

    fn dfs(
        node: Option<Rc<RefCell<TreeNode>>>,
        parent_val: i32,
        grandparent_val: i32,
        total_sum: &mut i32,
    ) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();

            if grandparent_val != -1 && grandparent_val % 2 == 0 {
                *total_sum += n.val;
            }

            Self::dfs(n.left.clone(), n.val, parent_val, total_sum);
            Self::dfs(n.right.clone(), n.val, parent_val, total_sum);
        }
    }
}