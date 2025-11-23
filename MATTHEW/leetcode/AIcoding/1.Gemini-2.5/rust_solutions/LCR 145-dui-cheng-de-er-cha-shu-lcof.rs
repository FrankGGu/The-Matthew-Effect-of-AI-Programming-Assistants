use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_symmetric(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        match root {
            None => true,
            Some(node) => {
                let node_ref = node.borrow();
                Self::is_mirror(node_ref.left.clone(), node_ref.right.clone())
            }
        }
    }

    fn is_mirror(t1: Option<Rc<RefCell<TreeNode>>>, t2: Option<Rc<RefCell<TreeNode>>>) -> bool {
        match (t1, t2) {
            (None, None) => true,
            (Some(n1), Some(n2)) => {
                let n1_ref = n1.borrow();
                let n2_ref = n2.borrow();
                n1_ref.val == n2_ref.val
                    && Self::is_mirror(n1_ref.left.clone(), n2_ref.right.clone())
                    && Self::is_mirror(n1_ref.right.clone(), n2_ref.left.clone())
            }
            _ => false,
        }
    }
}