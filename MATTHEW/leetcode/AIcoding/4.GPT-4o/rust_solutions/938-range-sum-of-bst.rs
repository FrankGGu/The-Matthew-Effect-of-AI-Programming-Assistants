use std::rc::Rc;
use std::cell::RefCell;

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

pub fn range_sum_bst(root: Option<Rc<RefCell<TreeNode>>>, low: i32, high: i32) -> i32 {
    fn dfs(node: Option<&Rc<RefCell<TreeNode>>>, low: i32, high: i32) -> i32 {
        if let Some(n) = node {
            let val = n.borrow().val;
            if val < low {
                return dfs(n.borrow().right.as_ref(), low, high);
            } else if val > high {
                return dfs(n.borrow().left.as_ref(), low, high);
            } else {
                return val + dfs(n.borrow().left.as_ref(), low, high) + dfs(n.borrow().right.as_ref(), low, high);
            }
        }
        0
    }
    dfs(root.as_ref(), low, high)
}