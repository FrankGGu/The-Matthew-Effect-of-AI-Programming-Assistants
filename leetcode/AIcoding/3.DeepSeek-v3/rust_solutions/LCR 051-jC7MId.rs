use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn max_path_sum(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut max_sum = i32::MIN;
        Self::max_gain(&root, &mut max_sum);
        max_sum
    }

    fn max_gain(node: &Option<Rc<RefCell<TreeNode>>>, max_sum: &mut i32) -> i32 {
        if let Some(n) = node {
            let node = n.borrow();
            let left_gain = std::cmp::max(Self::max_gain(&node.left, max_sum), 0);
            let right_gain = std::cmp::max(Self::max_gain(&node.right, max_sum), 0);

            let current_sum = node.val + left_gain + right_gain;
            *max_sum = std::cmp::max(*max_sum, current_sum);

            node.val + std::cmp::max(left_gain, right_gain)
        } else {
            0
        }
    }
}