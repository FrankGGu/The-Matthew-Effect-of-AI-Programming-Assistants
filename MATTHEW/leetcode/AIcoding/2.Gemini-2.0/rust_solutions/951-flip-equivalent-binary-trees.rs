use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn flip_equiv(root1: Option<Rc<RefCell<TreeNode>>>, root2: Option<Rc<RefCell<TreeNode>>>) -> bool {
        match (root1, root2) {
            (None, None) => true,
            (Some(r1), Some(r2)) => {
                let b1 = r1.borrow();
                let b2 = r2.borrow();
                if b1.val != b2.val {
                    false
                } else {
                    Solution::flip_equiv(b1.left.clone(), b2.left.clone()) && Solution::flip_equiv(b1.right.clone(), b2.right.clone()) ||
                    Solution::flip_equiv(b1.left.clone(), b2.right.clone()) && Solution::flip_equiv(b1.right.clone(), b2.left.clone())
                }
            }
            _ => false,
        }
    }
}