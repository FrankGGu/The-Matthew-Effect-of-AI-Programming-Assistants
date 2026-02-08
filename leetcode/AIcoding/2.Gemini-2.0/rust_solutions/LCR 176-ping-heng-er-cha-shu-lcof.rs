use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_balanced(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn height(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
            match node {
                None => 0,
                Some(n) => {
                    let left_height = height(&n.borrow().left);
                    let right_height = height(&n.borrow().right);
                    if left_height == -1 || right_height == -1 || (left_height - right_height).abs() > 1 {
                        return -1;
                    }
                    1 + std::cmp::max(left_height, right_height)
                }
            }
        }

        height(&root) != -1
    }
}