use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_substructure(a: Option<Rc<RefCell<TreeNode>>>, b: Option<Rc<RefCell<TreeNode>>>) -> bool {
        if a.is_none() || b.is_none() {
            return false;
        }

        Self::dfs(&a, &b)
            || Self::is_substructure(a.as_ref().unwrap().borrow().left.clone(), b.clone())
            || Self::is_substructure(a.as_ref().unwrap().borrow().right.clone(), b.clone())
    }

    fn dfs(a: &Option<Rc<RefCell<TreeNode>>>, b: &Option<Rc<RefCell<TreeNode>>>) -> bool {
        if b.is_none() {
            return true;
        }
        if a.is_none() {
            return false;
        }

        let a_node = a.as_ref().unwrap().borrow();
        let b_node = b.as_ref().unwrap().borrow();

        a_node.val == b_node.val
            && Self::dfs(&a_node.left, &b_node.left)
            && Self::dfs(&a_node.right, &b_node.right)
    }
}