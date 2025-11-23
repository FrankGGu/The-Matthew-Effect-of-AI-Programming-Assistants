use std::rc::Rc;
use std::cell::RefCell;

struct TreeNode {
    val: i32,
    left: Option<Rc<RefCell<TreeNode>>>,
    right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn search_bst(root: Option<Rc<RefCell<TreeNode>>>, val: i32) -> Option<Rc<RefCell<TreeNode>>> {
    let mut current = root;
    while let Some(node) = current {
        let node_ref = node.borrow();
        if node_ref.val == val {
            return Some(node.clone());
        } else if val < node_ref.val {
            current = node_ref.left.clone();
        } else {
            current = node_ref.right.clone();
        }
    }
    None
}