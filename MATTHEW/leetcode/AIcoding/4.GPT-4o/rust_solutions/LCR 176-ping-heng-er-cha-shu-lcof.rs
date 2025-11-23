use std::rc::Rc;
use std::cell::RefCell;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub struct Solution;

impl Solution {
    pub fn is_balanced(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn height(node: Option<&Rc<RefCell<TreeNode>>>) -> i32 {
            match node {
                Some(n) => {
                    let left_height = height(n.borrow().left.as_ref());
                    let right_height = height(n.borrow().right.as_ref());
                    if left_height == -1 || right_height == -1 || (left_height - right_height).abs() > 1 {
                        -1
                    } else {
                        1 + left_height.max(right_height)
                    }
                }
                None => 0,
            }
        }
        height(root.as_ref()) != -1
    }
}