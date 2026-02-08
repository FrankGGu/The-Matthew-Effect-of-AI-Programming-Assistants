use std::rc::Rc;
use std::cell::RefCell;

struct Solution;

impl Solution {
    pub fn get_minimum_difference(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut min_diff = i32::MAX;
        let mut prev_val: Option<i32> = None;

        Self::inorder_traverse(root, &mut min_diff, &mut prev_val);

        min_diff
    }

    fn inorder_traverse(node: Option<Rc<RefCell<TreeNode>>>, min_diff: &mut i32, prev_val: &mut Option<i32>) {
        if let Some(n_rc) = node {
            let n = n_rc.borrow();

            Self::inorder_traverse(n.left.clone(), min_diff, prev_val);

            if let Some(p_val) = *prev_val {
                *min_diff = (*min_diff).min((n.val - p_val).abs());
            }
            *prev_val = Some(n.val);

            Self::inorder_traverse(n.right.clone(), min_diff, prev_val);
        }
    }
}