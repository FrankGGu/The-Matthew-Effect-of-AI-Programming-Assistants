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

pub fn longest_zig_zag(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, is_left: bool, length: i32) -> i32 {
        match node {
            Some(n) => {
                let mut left_length = dfs(n.borrow().left.clone(), true, length + 1);
                let mut right_length = dfs(n.borrow().right.clone(), false, length + 1);
                if is_left {
                    left_length = length;
                } else {
                    right_length = length;
                }
                left_length.max(right_length)
            }
            None => length - 1,
        }
    }

    let left = dfs(root.clone(), true, 0);
    let right = dfs(root.clone(), false, 0);
    left.max(right)
}