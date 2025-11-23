impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

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

pub fn max_product(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: &Rc<RefCell<TreeNode>>) -> i32 {
        let mut sum = node.borrow().val;
        if let Some(left) = &node.borrow().left {
            sum += dfs(left);
        }
        if let Some(right) = &node.borrow().right {
            sum += dfs(right);
        }
        sum
    }

    let total = dfs(&root.unwrap());

    let mut result = 0;

    fn helper(node: &Rc<RefCell<TreeNode>>, total: i32, result: &mut i32) {
        let mut current = node.borrow().val;
        if let Some(left) = &node.borrow().left {
            current += helper(left, total, result);
        }
        if let Some(right) = &node.borrow().right {
            current += helper(right, total, result);
        }

        if let Some(left) = &node.borrow().left {
            let left_sum = helper(left, total, result);
            let product = left_sum * (total - left_sum);
            *result = std::cmp::max(*result, product);
        }

        if let Some(right) = &node.borrow().right {
            let right_sum = helper(right, total, result);
            let product = right_sum * (total - right_sum);
            *result = std::cmp::max(*result, product);
        }

        current
    }

    helper(&root.unwrap(), total, &mut result);

    result % 1000000007
}
}