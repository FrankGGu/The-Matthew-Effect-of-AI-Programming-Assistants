use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn merge_trees(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        match (root1, root2) {
            (Some(n1), Some(n2)) => {
                let mut n1_borrow = n1.borrow_mut();
                let n2_borrow = n2.borrow();
                let mut node = TreeNode::new(n1_borrow.val + n2_borrow.val);
                node.left = Self::merge_trees(n1_borrow.left.clone(), n2_borrow.left.clone());
                node.right = Self::merge_trees(n1_borrow.right.clone(), n2_borrow.right.clone());
                Some(Rc::new(RefCell::new(node)))
            }
            (Some(n1), None) => Some(n1),
            (None, Some(n2)) => Some(n2),
            (None, None) => None,
        }
    }
}