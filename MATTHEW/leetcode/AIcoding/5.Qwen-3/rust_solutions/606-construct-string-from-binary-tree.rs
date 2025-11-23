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

pub fn tree_to_string(root: Option<Rc<RefCell<TreeNode>>>) -> String {
    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, result: &mut String) {
        if let Some(n) = node {
            let n = n.borrow();
            result.push_str(&n.val.to_string());
            if n.left.is_some() || n.right.is_some() {
                result.push('(');
                dfs(&n.left, result);
                result.push(')');
                if n.right.is_some() {
                    result.push('(');
                    dfs(&n.right, result);
                    result.push(')');
                }
            }
        }
    }

    let mut res = String::new();
    dfs(&root, &mut res);
    res
}
}