use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn find_tilt(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut total_tilt = 0;
        Self::calculate_subtree_sum_and_tilt(root, &mut total_tilt);
        total_tilt
    }

    fn calculate_subtree_sum_and_tilt(node: Option<Rc<RefCell<TreeNode>>>, total_tilt_accumulator: &mut i32) -> i32 {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();
            let left_sum = Self::calculate_subtree_sum_and_tilt(n.left.clone(), total_tilt_accumulator);
            let right_sum = Self::calculate_subtree_sum_and_tilt(n.right.clone(), total_tilt_accumulator);

            *total_tilt_accumulator += (left_sum - right_sum).abs();

            n.val + left_sum + right_sum
        } else {
            0
        }
    }
}