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

impl Solution {
    pub fn decorate_tree(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, is_left: bool, parent_val: i32) {
            if let Some(n) = node {
                let mut mut_n = n.borrow_mut();
                let current_val = mut_n.val;
                if is_left {
                    mut_n.val = parent_val + 1;
                } else {
                    mut_n.val = parent_val - 1;
                }

                dfs(&mut_n.left, true, mut_n.val);
                dfs(&mut_n.right, false, mut_n.val);
            }
        }

        if let Some(r) = &root {
            dfs(&r.borrow().left, true, r.borrow().val);
            dfs(&r.borrow().right, false, r.borrow().val);
        }

        root
    }
}

struct Solution;