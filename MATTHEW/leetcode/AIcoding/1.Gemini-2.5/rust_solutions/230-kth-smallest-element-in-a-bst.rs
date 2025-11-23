use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn kth_smallest(root: Option<Rc<RefCell<TreeNode>>>, k: i32) -> i32 {
        let mut count = 0;
        let mut result = 0;
        Self::inorder_traverse(root, k, &mut count, &mut result);
        result
    }

    fn inorder_traverse(node: Option<Rc<RefCell<TreeNode>>>, k: i32, count: &mut i32, result: &mut i32) {
        if let Some(n) = node {
            let n_borrowed = n.borrow();

            Self::inorder_traverse(n_borrowed.left.clone(), k, count, result);

            if *count >= k {
                return;
            }

            *count += 1;
            if *count == k {
                *result = n_borrowed.val;
                return;
            }

            Self::inorder_traverse(n_borrowed.right.clone(), k, count, result);
        }
    }
}