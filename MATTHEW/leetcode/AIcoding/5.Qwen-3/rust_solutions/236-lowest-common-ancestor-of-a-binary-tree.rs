impl Solution {

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
    pub fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub fn lowest_common_ancestor(
    root: Option<Rc<RefCell<TreeNode>>>,
    p: Option<Rc<RefCell<TreeNode>>>,
    q: Option<Rc<RefCell<TreeNode>>>,
) -> Option<Rc<RefCell<TreeNode>>> {
    fn find_lca(
        root: Option<Rc<RefCell<TreeNode>>>,
        p: &Rc<RefCell<TreeNode>>,
        q: &Rc<RefCell<TreeNode>>,
    ) -> Option<Rc<RefCell<TreeNode>>> {
        if root.is_none() {
            return None;
        }

        let current = root.unwrap();
        let current_val = current.borrow().val;

        if current_val == p.borrow().val || current_val == q.borrow().val {
            return Some(current);
        }

        let left = find_lca(current.borrow().left.clone(), p, q);
        let right = find_lca(current.borrow().right.clone(), p, q);

        if left.is_some() && right.is_some() {
            return Some(current);
        }

        left.or(right)
    }

    find_lca(root, &p.unwrap(), &q.unwrap())
}
}