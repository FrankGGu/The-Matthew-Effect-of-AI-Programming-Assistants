use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn lowest_common_ancestor(
        root: Option<Rc<RefCell<TreeNode>>>,
        p: Option<Rc<RefCell<TreeNode>>>,
        q: Option<Rc<RefCell<TreeNode>>>,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        let mut current_node = root;
        let p_val = p.as_ref().unwrap().borrow().val;
        let q_val = q.as_ref().unwrap().borrow().val;

        while let Some(node_rc) = current_node.clone() {
            let node = node_rc.borrow();
            let node_val = node.val;

            if p_val < node_val && q_val < node_val {
                current_node = node.left.clone();
            } else if p_val > node_val && q_val > node_val {
                current_node = node.right.clone();
            } else {
                return Some(node_rc.clone());
            }
        }
        None
    }
}