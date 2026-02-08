use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn sufficient_subset(root: Option<Rc<RefCell<TreeNode>>>, limit: i32) -> Option<Rc<RefCell<TreeNode>>> {
        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, sum: i32, limit: i32) -> Option<Rc<RefCell<TreeNode>>> {
            if let Some(n) = node {
                let mut node = n.borrow_mut();
                let new_sum = sum + node.val;
                if node.left.is_none() && node.right.is_none() {
                    if new_sum < limit {
                        return None;
                    } else {
                        return Some(Rc::clone(&n));
                    }
                }
                let left = dfs(node.left.take(), new_sum, limit);
                let right = dfs(node.right.take(), new_sum, limit);
                node.left = left;
                node.right = right;
                if node.left.is_none() && node.right.is_none() {
                    return None;
                } else {
                    return Some(Rc::clone(&n));
                }
            } else {
                None
            }
        }
        dfs(root, 0, limit)
    }
}