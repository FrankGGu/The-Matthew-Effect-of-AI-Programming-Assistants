use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn light_up(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>) -> (i32, bool) {
            if let Some(n) = node {
                let left = dfs(&n.borrow().left);
                let right = dfs(&n.borrow().right);

                if !left.1 || !right.1 {
                    (left.0 + right.0 + 1, true)
                } else {
                    (left.0 + right.0, false)
                }
            } else {
                (0, false)
            }
        }

        let result = dfs(&root);
        if !result.1 && root.is_some() {
            result.0 + 1
        } else {
            result.0
        }
    }
}

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

struct Solution;