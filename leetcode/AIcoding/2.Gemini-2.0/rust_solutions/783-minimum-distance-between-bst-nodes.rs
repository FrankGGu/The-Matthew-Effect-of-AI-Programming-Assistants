use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn min_diff_in_bst(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut values = Vec::new();
        Self::inorder(root, &mut values);
        let mut min_diff = i32::MAX;
        for i in 1..values.len() {
            min_diff = min_diff.min(values[i] - values[i - 1]);
        }
        min_diff
    }

    fn inorder(node: Option<Rc<RefCell<TreeNode>>>, values: &mut Vec<i32>) {
        if let Some(node) = node {
            let node_ref = node.borrow();
            Self::inorder(node_ref.left.clone(), values);
            values.push(node_ref.val);
            Self::inorder(node_ref.right.clone(), values);
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