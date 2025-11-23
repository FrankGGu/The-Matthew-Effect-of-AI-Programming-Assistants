use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn is_balanced(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn check(node: Option<Rc<RefCell<TreeNode>>>) -> (bool, i32) {
            match node {
                None => (true, 0),
                Some(n) => {
                    let n = n.borrow();
                    let (left_balanced, left_height) = check(n.left.clone());
                    let (right_balanced, right_height) = check(n.right.clone());
                    let balanced = left_balanced && right_balanced && (left_height - right_height).abs() <= 1;
                    let height = 1 + std::cmp::max(left_height, right_height);
                    (balanced, height)
                }
            }
        }
        let (balanced, _) = check(root);
        balanced
    }
}