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

impl Solution {
    pub fn is_cousins(root: Option<Rc<RefCell<TreeNode>>>, x: i32, y: i32) -> bool {
        fn dfs(
            node: Option<Rc<RefCell<TreeNode>>>,
            target: i32,
            parent: Option<i32>,
            depth: i32,
        ) -> Option<(i32, i32)> {
            if let Some(n) = node {
                let n_borrow = n.borrow();
                if n_borrow.val == target {
                    return Some((parent.unwrap_or(-1), depth));
                }

                let left_res = dfs(n_borrow.left.clone(), target, Some(n_borrow.val), depth + 1);
                if left_res.is_some() {
                    return left_res;
                }

                let right_res = dfs(n_borrow.right.clone(), target, Some(n_borrow.val), depth + 1);
                if right_res.is_some() {
                    return right_res;
                }
            }
            None
        }

        let x_info = dfs(root.clone(), x, None, 0);
        let y_info = dfs(root.clone(), y, None, 0);

        if let (Some((x_parent, x_depth)), Some((y_parent, y_depth))) = (x_info, y_info) {
            x_depth == y_depth && x_parent != y_parent
        } else {
            false
        }
    }
}

struct Solution;