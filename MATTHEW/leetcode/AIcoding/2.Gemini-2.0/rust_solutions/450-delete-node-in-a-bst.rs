use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn delete_node(
        root: Option<Rc<RefCell<TreeNode>>>,
        key: i32,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        match root {
            None => None,
            Some(node) => {
                let mut node_ref = node.borrow_mut();
                if key < node_ref.val {
                    node_ref.left = Self::delete_node(node_ref.left.clone(), key);
                    Some(node.clone())
                } else if key > node_ref.val {
                    node_ref.right = Self::delete_node(node_ref.right.clone(), key);
                    Some(node.clone())
                } else {
                    match (node_ref.left.clone(), node_ref.right.clone()) {
                        (None, None) => None,
                        (Some(left), None) => Some(left.clone()),
                        (None, Some(right)) => Some(right.clone()),
                        (Some(left), Some(right)) => {
                            let mut min_node = right.clone();
                            let mut min_node_ref = min_node.borrow_mut();
                            while min_node_ref.left.is_some() {
                                min_node = min_node_ref.left.clone().unwrap();
                                min_node_ref = min_node.borrow_mut();
                            }
                            node_ref.val = min_node_ref.val;
                            node_ref.right = Self::delete_node(node_ref.right.clone(), min_node_ref.val);
                            Some(node.clone())
                        }
                    }
                }
            }
        }
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