use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn find_tilt(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut total_tilt = 0;
        Self::sum_and_tilt(root.as_ref(), &mut total_tilt);
        total_tilt
    }

    fn sum_and_tilt(node: Option<&Rc<RefCell<TreeNode>>>, total_tilt: &mut i32) -> i32 {
        if let Some(n) = node {
            let n = n.borrow();
            let left_sum = Self::sum_and_tilt(n.left.as_ref(), total_tilt);
            let right_sum = Self::sum_and_tilt(n.right.as_ref(), total_tilt);
            *total_tilt += (left_sum - right_sum).abs();
            left_sum + right_sum + n.val
        } else {
            0
        }
    }
}