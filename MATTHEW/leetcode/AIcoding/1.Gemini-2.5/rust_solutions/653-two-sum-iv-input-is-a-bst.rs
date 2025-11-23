use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashSet;

impl Solution {
    pub fn find_target(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> bool {
        let mut seen_values: HashSet<i32> = HashSet::new();
        Self::dfs(root, k, &mut seen_values)
    }

    fn dfs(node_opt: Option<Rc<RefCell<TreeNode>>>, k: i32, seen_values: &mut HashSet<i32>) -> bool {
        if let Some(node_rc) = node_opt {
            let node = node_rc.borrow();
            let current_val = node.val;

            if seen_values.contains(&(k - current_val)) {
                return true;
            }

            seen_values.insert(current_val);

            if Self::dfs(node.left.clone(), k, seen_values) {
                return true;
            }

            if Self::dfs(node.right.clone(), k, seen_values) {
                return true;
            }
        }
        false
    }
}