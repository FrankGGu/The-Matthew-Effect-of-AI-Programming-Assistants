use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

impl TreeNode {
    #[inline]
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

struct Solution;

impl Solution {
    pub fn subtree_with_all_deepest(root: Option<Rc<RefCell<TreeNode>>>) -> Option<Rc<RefCell<TreeNode>>> {
        fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, depth: &mut i32) -> (Option<Rc<RefCell<TreeNode>>>, i32) {
            if let Some(n) = node {
                let left = dfs(n.borrow().left.as_ref(), depth);
                let right = dfs(n.borrow().right.as_ref(), depth);

                *depth = (*depth).max(left.1).max(right.1) + 1;

                if left.1 == right.1 {
                    return (Some(n.clone()), left.1);
                } else if left.1 > right.1 {
                    return (left.0, left.1);
                } else {
                    return (right.0, right.1);
                }
            }
            (None, 0)
        }

        let mut depth = 0;
        dfs(root.as_ref(), &mut depth).0
    }
}