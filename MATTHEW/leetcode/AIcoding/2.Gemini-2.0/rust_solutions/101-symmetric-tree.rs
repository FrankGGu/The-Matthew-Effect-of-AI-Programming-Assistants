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
    pub fn is_symmetric(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn is_mirror(t1: Option<Rc<RefCell<TreeNode>>>, t2: Option<Rc<RefCell<TreeNode>>>) -> bool {
            match (t1, t2) {
                (None, None) => true,
                (Some(n1), Some(n2)) => {
                    let b1 = n1.borrow();
                    let b2 = n2.borrow();
                    b1.val == b2.val &&
                    is_mirror(b1.left.clone(), b2.right.clone()) &&
                    is_mirror(b1.right.clone(), b2.left.clone())
                },
                _ => false,
            }
        }

        match root {
            Some(r) => {
                let b = r.borrow();
                is_mirror(b.left.clone(), b.right.clone())
            },
            None => true,
        }
    }
}

struct Solution;