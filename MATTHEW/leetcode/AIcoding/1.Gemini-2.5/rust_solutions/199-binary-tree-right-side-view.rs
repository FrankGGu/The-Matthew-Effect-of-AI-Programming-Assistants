use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn right_side_view(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<i32> {
        let mut result = Vec::new();
        Self::dfs(&root, 0, &mut result);
        result
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, depth: usize, result: &mut Vec<i32>) {
        if let Some(n) = node {
            let n_borrow = n.borrow();
            if depth == result.len() {
                result.push(n_borrow.val);
            }
            Self::dfs(&n_borrow.right, depth + 1, result);
            Self::dfs(&n_borrow.left, depth + 1, result);
        }
    }
}