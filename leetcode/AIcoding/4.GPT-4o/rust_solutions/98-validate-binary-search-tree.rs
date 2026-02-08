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
    pub fn is_valid_bst(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn helper(node: Option<&Rc<RefCell<TreeNode>>>, lower: i32, upper: i32) -> bool {
            if let Some(n) = node {
                let val = n.borrow().val;
                if val <= lower || val >= upper {
                    return false;
                }
                return helper(n.borrow().left.as_ref(), lower, val) && helper(n.borrow().right.as_ref(), val, upper);
            }
            true
        }
        helper(root.as_ref(), i32::MIN, i32::MAX)
    }
}