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

pub fn find_second_minimum_value(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    let mut min1 = i32::MAX;
    let mut min2 = i32::MAX;

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, min1: &mut i32, min2: &mut i32) {
        if let Some(n) = node {
            let val = n.borrow().val;
            if val < *min1 {
                *min2 = *min1;
                *min1 = val;
            } else if val > *min1 && val < *min2 {
                *min2 = val;
            }
            dfs(n.borrow().left.clone(), min1, min2);
            dfs(n.borrow().right.clone(), min1, min2);
        }
    }

    dfs(root, &mut min1, &mut min2);
    if min2 == i32::MAX { -1 } else { min2 }
}