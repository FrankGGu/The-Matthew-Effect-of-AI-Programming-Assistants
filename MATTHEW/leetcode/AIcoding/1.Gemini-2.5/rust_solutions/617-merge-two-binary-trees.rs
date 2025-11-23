use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn merge_trees(t1: Option<Rc<RefCell<TreeNode>>>, t2: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        match (t1, t2) {
            (Some(node1), Some(node2)) => {
                let mut b_node1 = node1.borrow_mut();
                let b_node2 = node2.borrow();

                b_node1.val += b_node2.val;
                b_node1.left = Self::merge_trees(b_node1.left.take(), b_node2.left.clone());
                b_node1.right = Self::merge_trees(b_node1.right.take(), b_node2.right.clone());

                Some(node1)
            },
            (Some(node1), None) => Some(node1),
            (None, Some(node2)) => Some(node2),
            (None, None) => None,
        }
    }
}