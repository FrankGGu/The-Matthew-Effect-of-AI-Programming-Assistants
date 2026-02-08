use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn pseudo_palindromic_paths(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, mut freq: i32) -> i32 {
            if let Some(n) = node {
                let node_ref = n.borrow();
                freq ^= 1 << node_ref.val;
                if node_ref.left.is_none() && node_ref.right.is_none() {
                    return if (freq & (freq - 1)) == 0 { 1 } else { 0 };
                }
                return dfs(node_ref.left.clone(), freq) + dfs(node_ref.right.clone(), freq);
            }
            0
        }
        dfs(root, 0)
    }
}