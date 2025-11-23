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

pub fn deepest_leaves_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    use std::collections::VecDeque;

    let mut queue = VecDeque::new();
    if let Some(node) = root {
        queue.push_back(node);
    }

    let mut sum = 0;

    while !queue.is_empty() {
        let level_size = queue.len();
        sum = 0;

        for _ in 0..level_size {
            if let Some(node) = queue.pop_front() {
                sum += node.borrow().val;

                if let Some(left) = &node.borrow().left {
                    queue.push_back(Rc::clone(left));
                }
                if let Some(right) = &node.borrow().right {
                    queue.push_back(Rc::clone(right));
                }
            }
        }
    }

    sum
}
}