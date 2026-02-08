use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn find_target(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> bool {
        let mut set = std::collections::HashSet::new();
        Self::dfs(root, k, &mut set)
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, k: i32, set: &mut std::collections::HashSet<i32>) -> bool {
        if let Some(n) = node {
            let val = n.borrow().val;
            if set.contains(&(k - val)) {
                return true;
            }
            set.insert(val);
            Self::dfs(n.borrow().left.clone(), k, set) || Self::dfs(n.borrow().right.clone(), k, set)
        } else {
            false
        }
    }
}