use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn lowest_common_ancestor(root: Option<Rc<RefCell<TreeNode>>>, p: Option<Rc<RefCell<TreeNode>>>, q: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let root_node = root.as_ref().unwrap().borrow();
        let p_node = p.as_ref().unwrap().borrow();
        let q_node = q.as_ref().unwrap().borrow();

        if Rc::ptr_eq(root.as_ref().unwrap(), p.as_ref().unwrap()) || Rc::ptr_eq(root.as_ref().unwrap(), q.as_ref().unwrap()) {
            return root.clone();
        }

        let left = Solution::lowest_common_ancestor(root_node.left.clone(), p.clone(), q.clone());
        let right = Solution::lowest_common_ancestor(root_node.right.clone(), p.clone(), q.clone());

        if left.is_some() && right.is_some() {
            return root.clone();
        } else if left.is_some() {
            return left;
        } else {
            return right;
        }
    }
}