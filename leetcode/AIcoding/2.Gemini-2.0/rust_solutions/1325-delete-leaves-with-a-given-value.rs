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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn remove_leaf_nodes(
        root: Option<Rc<RefCell<TreeNode>>>,
        target: i32,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let mut root_node = root.unwrap();
        let mut root_ref = root_node.borrow_mut();

        root_ref.left = Solution::remove_leaf_nodes(root_ref.left.take(), target);
        root_ref.right = Solution::remove_leaf_nodes(root_ref.right.take(), target);

        if root_ref.left.is_none() && root_ref.right.is_none() && root_ref.val == target {
            return None;
        }

        Some(Rc::new(RefCell::new(TreeNode {
            val: root_ref.val,
            left: root_ref.left.take(),
            right: root_ref.right.take(),
        })))
    }
}

struct Solution;