use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn lca_deepest_leaves(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        fn helper(node: &Option<Rc<RefCell<TreeNode>>>) -> (Option<Rc<RefCell<TreeNode>>>, i32) {
            match node {
                None => (None, 0),
                Some(n) => {
                    let (left_lca, left_depth) = helper(&n.borrow().left);
                    let (right_lca, right_depth) = helper(&n.borrow().right);
                    if left_depth > right_depth {
                        (left_lca, left_depth + 1)
                    } else if right_depth > left_depth {
                        (right_lca, right_depth + 1)
                    } else {
                        (Some(n.clone()), left_depth + 1)
                    }
                }
            }
        }
        helper(&root).0
    }
}