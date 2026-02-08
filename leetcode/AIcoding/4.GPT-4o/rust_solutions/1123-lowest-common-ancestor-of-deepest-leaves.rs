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
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub struct Solution;

impl Solution {
    pub fn lca_deepest_leaves(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, depth: i32, max_depth: &mut i32, lca: &mut Option<Rc<RefCell<TreeNode>>>) -> i32 {
            if let Some(n) = node {
                let left_depth = dfs(n.borrow().left.clone(), depth + 1, max_depth, lca);
                let right_depth = dfs(n.borrow().right.clone(), depth + 1, max_depth, lca);

                let current_depth = left_depth.max(right_depth);

                if current_depth > *max_depth {
                    *max_depth = current_depth;
                    *lca = Some(n.clone());
                } else if current_depth == *max_depth {
                    *lca = Some(n.clone());
                }

                current_depth
            } else {
                depth
            }
        }

        let mut max_depth = -1;
        let mut lca = None;
        dfs(root, 0, &mut max_depth, &mut lca);
        lca
    }
}