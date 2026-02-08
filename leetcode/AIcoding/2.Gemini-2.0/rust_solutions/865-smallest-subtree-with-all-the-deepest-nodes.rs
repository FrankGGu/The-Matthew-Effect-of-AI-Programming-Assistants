use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashMap;

impl Solution {
    pub fn subtree_with_all_deepest(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        fn depth(node: &Option<Rc<RefCell<TreeNode>>>) -> i32 {
            match node {
                Some(n) => {
                    let n = n.borrow();
                    1 + std::cmp::max(depth(&n.left), depth(&n.right))
                }
                None => 0,
            }
        }

        fn helper(node: &Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
            match node {
                Some(n) => {
                    let n = n.borrow();
                    let left_depth = depth(&n.left);
                    let right_depth = depth(&n.right);

                    if left_depth == right_depth {
                        return Some(Rc::clone(node.as_ref().unwrap()));
                    } else if left_depth > right_depth {
                        return helper(&n.left);
                    } else {
                        return helper(&n.right);
                    }
                }
                None => None,
            }
        }

        helper(&root)
    }
}