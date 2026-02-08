use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_symmetric(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn is_mirror(
            left: Option<Rc<RefCell<TreeNode>>>,
            right: Option<Rc<RefCell<TreeNode>>>,
        ) -> bool {
            match (left, right) {
                (None, None) => true,
                (Some(l), Some(r)) => {
                    let l_node = l.borrow();
                    let r_node = r.borrow();
                    l_node.val == r_node.val
                        && is_mirror(l_node.left.clone(), r_node.right.clone())
                        && is_mirror(l_node.right.clone(), r_node.left.clone())
                }
                _ => false,
            }
        }
        match root {
            None => true,
            Some(node) => {
                let node = node.borrow();
                is_mirror(node.left.clone(), node.right.clone())
            }
        }
    }
}