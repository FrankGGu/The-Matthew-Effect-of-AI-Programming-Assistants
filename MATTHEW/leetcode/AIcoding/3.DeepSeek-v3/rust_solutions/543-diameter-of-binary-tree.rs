use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn diameter_of_binary_tree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_diameter = 0;
        Self::dfs(&root, &mut max_diameter);
        max_diameter
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, max_diameter: &mut i32) -> i32 {
        if let Some(n) = node {
            let left = Self::dfs(&n.borrow().left, max_diameter);
            let right = Self::dfs(&n.borrow().right, max_diameter);
            *max_diameter = (*max_diameter).max(left + right);
            1 + left.max(right)
        } else {
            0
        }
    }
}