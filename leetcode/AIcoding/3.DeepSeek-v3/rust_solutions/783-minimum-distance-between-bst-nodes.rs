use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn min_diff_in_bst(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut prev = None;
        let mut min_diff = i32::MAX;
        Self::inorder_traversal(root, &mut prev, &mut min_diff);
        min_diff
    }

    fn inorder_traversal(node: Option<Rc<RefCell<TreeNode>>>, prev: &mut Option<i32>, min_diff: &mut i32) {
        if let Some(n) = node {
            let n = n.borrow();
            Self::inorder_traversal(n.left.clone(), prev, min_diff);
            if let Some(p) = prev {
                *min_diff = (*min_diff).min(n.val - *p);
            }
            *prev = Some(n.val);
            Self::inorder_traversal(n.right.clone(), prev, min_diff);
        }
    }
}