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
    pub fn insert_into_max_tree(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
        let new_node = Rc::new(RefCell::new(TreeNode::new(val)));
        if root.is_none() {
            return Some(new_node);
        }

        let mut current = root.clone();
        let mut parent = None;

        while let Some(node) = current {
            let node_val = node.borrow().val;
            if val > node_val {
                new_node.borrow_mut().left = Some(node.clone());
                if let Some(p) = parent {
                    p.borrow_mut().right = Some(new_node);
                    return root;
                } else {
                    return Some(new_node);
                }
            } else {
                parent = Some(node.clone());
                current = node.borrow().right.clone();
            }
        }

        if let Some(p) = parent {
            p.borrow_mut().right = Some(new_node);
        }

        root
    }
}