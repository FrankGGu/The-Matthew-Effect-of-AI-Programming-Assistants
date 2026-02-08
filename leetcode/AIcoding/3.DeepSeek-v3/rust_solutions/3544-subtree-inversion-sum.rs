use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn sum_inversions(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut sum = 0;
        Self::invert_and_sum(root, &mut sum);
        sum
    }

    fn invert_and_sum(node: Option<Rc<RefCell<TreeNode>>>, sum: &mut i32) -> Option<Rc<RefCell<TreeNode>>> {
        if let Some(inner_node) = node {
            let mut node_ref = inner_node.borrow_mut();
            let left = node_ref.left.take();
            let right = node_ref.right.take();
            let inverted_left = Self::invert_and_sum(right, sum);
            let inverted_right = Self::invert_and_sum(left, sum);
            node_ref.left = inverted_left;
            node_ref.right = inverted_right;
            *sum += node_ref.val;
            Some(inner_node.clone())
        } else {
            None
        }
    }
}