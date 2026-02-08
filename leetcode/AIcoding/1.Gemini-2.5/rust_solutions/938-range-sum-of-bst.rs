use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn range_sum_bst(root: Option<Rc<RefCell<TreeNode>>>, low: i32, high: i32) -> i32 {
        if let Some(node_rc) = root {
            let node = node_rc.borrow();
            let mut sum = 0;

            if node.val >= low && node.val <= high {
                sum += node.val;
            }

            if node.val > low {
                sum += Self::range_sum_bst(node.left.clone(), low, high);
            }

            if node.val < high {
                sum += Self::range_sum_bst(node.right.clone(), low, high);
            }

            sum
        } else {
            0
        }
    }
}