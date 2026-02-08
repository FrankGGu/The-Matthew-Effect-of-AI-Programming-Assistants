use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn rob(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn helper(node: &Option<Rc<RefCell<TreeNode>>>) -> (i32, i32) {
            match node {
                None => (0, 0),
                Some(n) => {
                    let n = n.borrow();
                    let left = helper(&n.left);
                    let right = helper(&n.right);
                    let rob = n.val + left.1 + right.1;
                    let not_rob = left.0.max(left.1) + right.0.max(right.1);
                    (rob, not_rob)
                }
            }
        }
        let res = helper(&root);
        res.0.max(res.1)
    }
}