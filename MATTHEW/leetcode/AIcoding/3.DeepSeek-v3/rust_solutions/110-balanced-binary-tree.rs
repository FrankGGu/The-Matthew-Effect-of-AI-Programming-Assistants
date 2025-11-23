use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_balanced(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn check_height(node: Option<Rc<RefCell<TreeNode>>>) -> i32 {
            match node {
                None => 0,
                Some(n) => {
                    let node_ref = n.borrow();
                    let left_height = check_height(node_ref.left.clone());
                    let right_height = check_height(node_ref.right.clone());
                    if left_height == -1 || right_height == -1 || (left_height - right_height).abs() > 1 {
                        -1
                    } else {
                        1 + std::cmp::max(left_height, right_height)
                    }
                }
            }
        }
        check_height(root) != -1
    }
}