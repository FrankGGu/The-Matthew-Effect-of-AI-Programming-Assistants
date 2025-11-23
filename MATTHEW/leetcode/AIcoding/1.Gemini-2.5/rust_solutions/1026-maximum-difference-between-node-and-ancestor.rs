use std::rc::Rc;
use std::cell::RefCell;
use std::cmp::{min, max};

impl Solution {
    pub fn max_ancestor_diff(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_diff = 0;
        if let Some(node_rc) = root {
            let node = node_rc.borrow();
            Self::dfs(&node_rc, node.val, node.val, &mut max_diff);
        }
        max_diff
    }

    fn dfs(
        node_rc: &Rc<RefCell<TreeNode>>,
        min_val_on_path: i32,
        max_val_on_path: i32,
        max_diff: &mut i32,
    ) {
        let node = node_rc.borrow();

        *max_diff = max(*max_diff, (node.val - min_val_on_path).abs());
        *max_diff = max(*max_diff, (node.val - max_val_on_path).abs());

        let new_min_val_on_path = min(min_val_on_path, node.val);
        let new_max_val_on_path = max(max_val_on_path, node.val);

        if let Some(left_child_rc) = &node.left {
            Self::dfs(left_child_rc, new_min_val_on_path, new_max_val_on_path, max_diff);
        }

        if let Some(right_child_rc) = &node.right {
            Self::dfs(right_child_rc, new_min_val_on_path, new_max_val_on_path, max_diff);
        }
    }
}