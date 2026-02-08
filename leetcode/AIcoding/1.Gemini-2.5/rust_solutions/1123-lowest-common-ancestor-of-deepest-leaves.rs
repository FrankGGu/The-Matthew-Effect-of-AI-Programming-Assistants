use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn lca_deepest_leaves(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        Self::dfs(root).1
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>) -> (i32, Option<Rc<RefCell<TreeNode>>>) {
        if node.is_none() {
            return (0, None);
        }

        let current_node_rc = node.as_ref().unwrap();
        let current_node_borrow = current_node_rc.borrow();

        let (left_depth, left_lca) = Self::dfs(current_node_borrow.left.clone());
        let (right_depth, right_lca) = Self::dfs(current_node_borrow.right.clone());

        if left_depth == right_depth {
            (left_depth + 1, Some(current_node_rc.clone()))
        } else if left_depth > right_depth {
            (left_depth + 1, left_lca)
        } else {
            (right_depth + 1, right_lca)
        }
    }
}