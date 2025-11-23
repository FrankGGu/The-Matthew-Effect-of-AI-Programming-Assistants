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
    pub fn leaf_similar(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> bool {
        let mut seq1 = Vec::new();
        let mut seq2 = Vec::new();

        Self::get_leaf_sequence(root1, &mut seq1);
        Self::get_leaf_sequence(root2, &mut seq2);

        seq1 == seq2
    }

    fn get_leaf_sequence(root: Option<Rc<RefCell<TreeNode>>>, seq: &mut Vec<i32>) {
        if let Some(node) = root {
            let node_ref = node.borrow();

            if node_ref.left.is_none() && node_ref.right.is_none() {
                seq.push(node_ref.val);
            } else {
                Self::get_leaf_sequence(node_ref.left.clone(), seq);
                Self::get_leaf_sequence(node_ref.right.clone(), seq);
            }
        }
    }
}

struct Solution;