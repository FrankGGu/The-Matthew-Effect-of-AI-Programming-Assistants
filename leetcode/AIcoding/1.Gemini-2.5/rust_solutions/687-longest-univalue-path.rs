use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn longest_univalue_path(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_len = 0;
        Self::dfs(root, &mut max_len);
        max_len
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, max_len: &mut i32) -> i32 {
        if node.is_none() {
            return 0;
        }

        let node_rc = node.unwrap();
        let node_val = node_rc.borrow().val;

        let left_path_len = Self::dfs(node_rc.borrow().left.clone(), max_len);
        let right_path_len = Self::dfs(node_rc.borrow().right.clone(), max_len);

        let mut current_left_unival_len = 0;
        if let Some(left_child_rc) = &node_rc.borrow().left {
            if left_child_rc.borrow().val == node_val {
                current_left_unival_len = 1 + left_path_len;
            }
        }

        let mut current_right_unival_len = 0;
        if let Some(right_child_rc) = &node_rc.borrow().right {
            if right_child_rc.borrow().val == node_val {
                current_right_unival_len = 1 + right_path_len;
            }
        }

        *max_len = (*max_len).max(current_left_unival_len + current_right_unival_len);

        current_left_unival_len.max(current_right_unival_len)
    }
}