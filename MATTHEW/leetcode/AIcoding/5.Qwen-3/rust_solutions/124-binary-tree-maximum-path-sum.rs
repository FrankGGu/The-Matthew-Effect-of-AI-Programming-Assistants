impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn max_path_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    let mut max_sum = i32::MIN;

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> i32 {
        if let Some(n) = node {
            let val = n.borrow().val;
            let left = dfs(n.borrow().left.clone(), max_sum);
            let right = dfs(n.borrow().right.clone(), max_sum);

            let current = val + left.max(0) + right.max(0);
            *max_sum = (*max_sum).max(current);

            val + left.max(0).max(right.max(0))
        } else {
            0
        }
    }

    dfs(root, &mut max_sum);
    max_sum
}
}