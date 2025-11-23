use std::rc::Rc;
use std::cell::RefCell;

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

pub fn merge_trees(t1: Option<Rc<RefCell<TreeNode>>>, t2: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
    match (t1, t2) {
        (None, None) => None,
        (Some(node1), None) => Some(node1),
        (None, Some(node2)) => Some(node2),
        (Some(node1), Some(node2)) => {
            let merged_value = node1.borrow().val + node2.borrow().val;
            let merged_node = Rc::new(RefCell::new(TreeNode::new(merged_value)));
            merged_node.borrow_mut().left = merge_trees(node1.borrow().left.clone(), node2.borrow().left.clone());
            merged_node.borrow_mut().right = merge_trees(node1.borrow().right.clone(), node2.borrow().right.clone());
            Some(merged_node)
        }
    }
}