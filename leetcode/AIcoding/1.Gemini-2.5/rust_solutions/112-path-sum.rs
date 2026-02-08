use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn has_path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> bool {
        if let Some(node_rc) = root {
            let node = node_rc.borrow();
            let remaining_sum = target_sum - node.val;

            if node.left.is_none() && node.right.is_none() {
                // This is a leaf node
                return remaining_sum == 0;
            }

            // Recurse on left and right children
            Self::has_path_sum(node.left.clone(), remaining_sum) ||
            Self::has_path_sum(node.right.clone(), remaining_sum)
        } else {
            // Empty tree, no path sum possible
            false
        }
    }
}