use std::rc::Rc;
use std::cell::RefCell;
impl Solution {
    pub fn is_valid_bst(root: Option<Rc<RefCell<TreeNode>>>) -> bool {
        fn helper(node: Option<Rc<RefCell<TreeNode>>>, min: Option<i32>, max: Option<i32>) -> bool {
            match node {
                None => true,
                Some(n) => {
                    let n = n.borrow();
                    if min.is_some() && n.val <= min.unwrap() {
                        return false;
                    }
                    if max.is_some() && n.val >= max.unwrap() {
                        return false;
                    }
                    helper(n.left.clone(), min, Some(n.val)) && helper(n.right.clone(), Some(n.val), max)
                }
            }
        }
        helper(root, None, None)
    }
}