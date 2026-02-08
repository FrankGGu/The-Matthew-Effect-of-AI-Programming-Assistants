use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn longest_univalue_path(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_len = 0;
        Self::dfs(&root, &mut max_len);
        max_len
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, max_len: &mut i32) -> i32 {
        if let Some(n) = node {
            let n = n.borrow();
            let left = Self::dfs(&n.left, max_len);
            let right = Self::dfs(&n.right, max_len);
            let mut left_len = 0;
            let mut right_len = 0;
            if let Some(left_node) = &n.left {
                if left_node.borrow().val == n.val {
                    left_len = left + 1;
                }
            }
            if let Some(right_node) = &n.right {
                if right_node.borrow().val == n.val {
                    right_len = right + 1;
                }
            }
            *max_len = (*max_len).max(left_len + right_len);
            left_len.max(right_len)
        } else {
            0
        }
    }
}