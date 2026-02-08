use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashSet;

impl Solution {
    pub fn find_target(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> bool {
        let mut set = HashSet::new();
        Self::helper(root, k, &mut set)
    }

    fn helper(node: Option<Rc<RefCell<TreeNode>>>, k: i32, set: &mut HashSet<i32>) -> bool {
        if let Some(n) = node {
            let val = n.borrow().val;
            if set.contains(&(k - val)) {
                return true;
            }
            set.insert(val);
            Self::helper(n.borrow().left.clone(), k, set) || Self::helper(n.borrow().right.clone(), k, set)
        } else {
            false
        }
    }
}