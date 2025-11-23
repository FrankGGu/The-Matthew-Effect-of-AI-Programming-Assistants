use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sufficient_subset(root: Option<Rc<RefCell<TreeNode>>>, limit: i32) -> Option<Rc<RefCell<TreeNode>>> {
        Self::dfs(root, 0, limit)
    }

    fn dfs(node_opt: Option<Rc<RefCell<TreeNode>>>, current_sum: i32, limit: i32) -> Option<Rc<RefCell<TreeNode>>> {
        let Some(node) = node_opt else {
            return None;
        };

        let new_sum = current_sum + node.borrow().val;

        // If it's a leaf node (before any pruning)
        if node.borrow().left.is_none() && node.borrow().right.is_none() {
            if new_sum < limit {
                return None; // This leaf path is insufficient, remove it
            } else {
                return Some(node); // This leaf path is sufficient, keep it
            }
        }

        // Not a leaf node, recursively process children
        let left_child = Self::dfs(node.borrow_mut().left.take(), new_sum, limit);
        let right_child = Self::dfs(node.borrow_mut().right.take(), new_sum, limit);

        node.borrow_mut().left = left_child;
        node.borrow_mut().right = right_child;

        // After processing children, check if this node became a leaf or if all its paths are insufficient
        if node.borrow().left.is_none() && node.borrow().right.is_none() {
            // This node is now effectively a leaf. Check its path sum.
            if new_sum < limit {
                return None; // Path to this new leaf is insufficient, remove it
            } else {
                return Some(node); // Path to this new leaf is sufficient, keep it
            }
        } else {
            // At least one child exists, meaning there's at least one sufficient path through this node.
            return Some(node);
        }
    }
}