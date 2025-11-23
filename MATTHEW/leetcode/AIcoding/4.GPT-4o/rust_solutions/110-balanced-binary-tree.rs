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
    pub fn is_balanced(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn height(node: &Option<Rc<RefCell<TreeNode>>>) -> (bool, i32) {
            match node {
                Some(n) => {
                    let left = height(&n.borrow().left);
                    let right = height(&n.borrow().right);
                    let balanced = left.0 && right.0 && (left.1 - right.1).abs() <= 1;
                    (balanced, 1 + left.1.max(right.1))
                }
                None => (true, 0),
            }
        }
        height(&root).0
    }
}