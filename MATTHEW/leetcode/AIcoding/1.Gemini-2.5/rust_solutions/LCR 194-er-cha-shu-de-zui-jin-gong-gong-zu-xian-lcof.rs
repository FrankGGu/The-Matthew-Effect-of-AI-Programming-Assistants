use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn lowest_common_ancestor(
        root: Option<Rc<RefCell<TreeNode>>>,
        p: Option<Rc<RefCell<TreeNode>>>,
        q: Option<Rc<RefCell<TreeNode>>>,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let root_ref = root.as_ref().unwrap();
        let p_ref = p.as_ref().unwrap();
        let q_ref = q.as_ref().unwrap();

        if Rc::ptr_eq(root_ref, p_ref) || Rc::ptr_eq(root_ref, q_ref) {
            return root;
        }

        let left_lca = Self::lowest_common_ancestor(
            root_ref.borrow().left.clone(),
            p.clone(),
            q.clone(),
        );
        let right_lca = Self::lowest_common_ancestor(
            root_ref.borrow().right.clone(),
            p.clone(),
            q.clone(),
        );

        match (left_lca, right_lca) {
            (Some(_), Some(_)) => root,
            (Some(node), None) => Some(node),
            (None, Some(node)) => Some(node),
            (None, None) => None,
        }
    }
}