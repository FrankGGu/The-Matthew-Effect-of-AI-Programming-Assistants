use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn largest_values(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::new();
        if root.is_none() {
            return result;
        }

        let mut queue: Vec<Rc<RefCell<TreeNode>>> = Vec::new();
        queue.push(root.unwrap());

        while !queue.is_empty() {
            let mut max_val = i32::min_value();
            let mut next_level: Vec<Rc<RefCell<TreeNode>>> = Vec::new();

            for node in queue.iter() {
                let borrowed_node = node.borrow();
                max_val = max_val.max(borrowed_node.val);

                if let Some(left) = borrowed_node.left.clone() {
                    next_level.push(left);
                }
                if let Some(right) = borrowed_node.right.clone() {
                    next_level.push(right);
                }
            }

            result.push(max_val);
            queue = next_level;
        }

        result
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