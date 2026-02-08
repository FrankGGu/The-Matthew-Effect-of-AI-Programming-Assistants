use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_symmetric(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if root.is_none() {
            return true;
        }

        let root_node = root.unwrap();
        let left_child = root_node.borrow().left.clone();
        let right_child = root_node.borrow().right.clone();

        Self::is_mirror(left_child, right_child)
    }

    fn is_mirror(t1: Option<Rc<RefCell<TreeNode>>>, t2: Option<Rc<RefCell<TreeNode>>>) -> bool {
        match (t1, t2) {
            (None, None) => true,
            (Some(node1), Some(node2)) => {
                let borrowed1 = node1.borrow();
                let borrowed2 = node2.borrow();

                borrowed1.val == borrowed2.val
                    && Self::is_mirror(borrowed1.left.clone(), borrowed2.right.clone())
                    && Self::is_mirror(borrowed1.right.clone(), borrowed2.left.clone())
            }
            _ => false,
        }
    }
}