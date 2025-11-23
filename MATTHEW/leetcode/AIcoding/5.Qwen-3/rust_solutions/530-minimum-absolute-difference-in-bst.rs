impl Solution {

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

pub fn get_minimum_difference(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    let mut min_diff = i32::MAX;
    let mut prev = None;

    fn in_order(
        node: Option<Rc<RefCell<TreeNode>>>,
        min_diff: &mut i32,
        prev: &mut Option<i32>,
    ) {
        if let Some(n) = node {
            in_order(n.borrow().left.clone(), min_diff, prev);
            if let Some(p) = *prev {
                *min_diff = std::cmp::min(*min_diff, n.borrow().val - p);
            }
            *prev = Some(n.borrow().val);
            in_order(n.borrow().right.clone(), min_diff, prev);
        }
    }

    in_order(root, &mut min_diff, &mut prev);
    min_diff
}
}