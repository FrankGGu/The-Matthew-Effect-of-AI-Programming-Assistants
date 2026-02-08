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
    pub fn tree_scheduling(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>) -> (i32, i32) {
            if let Some(n) = node {
                let (left_with, left_without) = dfs(n.borrow().left.clone());
                let (right_with, right_without) = dfs(n.borrow().right.clone());

                let with_node = n.borrow().val + left_without + right_without;
                let without_node =
                    (left_with).max(left_without) + (right_with).max(right_without);

                (with_node, without_node)
            } else {
                (0, 0)
            }
        }

        let (with, without) = dfs(root);
        with.max(without)
    }
}

struct Solution;