use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn flip_equiv(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> bool {
        match (root1, root2) {
            (None, None) => true,
            (Some(n1), Some(n2)) => {
                let n1 = n1.borrow();
                let n2 = n2.borrow();
                if n1.val != n2.val {
                    false
                } else {
                    (Self::flip_equiv(n1.left.clone(), n2.left.clone()) && Self::flip_equiv(n1.right.clone(), n2.right.clone())) ||
                    (Self::flip_equiv(n1.left.clone(), n2.right.clone()) && Self::flip_equiv(n1.right.clone(), n2.left.clone()))
                }
            }
            _ => false,
        }
    }
}