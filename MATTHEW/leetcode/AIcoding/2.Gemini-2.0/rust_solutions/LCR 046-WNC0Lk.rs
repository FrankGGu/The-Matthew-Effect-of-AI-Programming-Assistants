use std::cell::RefCell;
use std::rc::Rc;
use std::collections::VecDeque;

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
    pub fn right_side_view(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue = VecDeque::new();
        queue.push_back(root.unwrap());

        while !queue.is_empty() {
            let level_size = queue.len();
            for i in 0..level_size {
                let node = queue.pop_front().unwrap();
                if i == level_size - 1 {
                    result.push(node.borrow().val);
                }

                if let Some(left) = &node.borrow().left {
                    queue.push_back(Rc::clone(left));
                }
                if let Some(right) = &node.borrow().right {
                    queue.push_back(Rc::clone(right));
                }
            }
        }

        result
    }
}

struct Solution;