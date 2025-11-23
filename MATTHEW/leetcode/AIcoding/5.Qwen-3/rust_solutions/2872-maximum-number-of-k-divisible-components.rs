impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn number_of_components(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i32 {
    fn dfs(node: &Rc<RefCell<TreeNode>>, k: i32, result: &mut i32) -> i32 {
        let mut sum = node.borrow().val;
        if let Some(left) = &node.borrow().left {
            sum += dfs(left, k, result);
        }
        if let Some(right) = &node.borrow().right {
            sum += dfs(right, k, result);
        }
        if sum % k == 0 {
            *result += 1;
        }
        sum
    }

    let mut result = 0;
    if let Some(root) = root {
        dfs(&root, k, &mut result);
    }
    result
}
}