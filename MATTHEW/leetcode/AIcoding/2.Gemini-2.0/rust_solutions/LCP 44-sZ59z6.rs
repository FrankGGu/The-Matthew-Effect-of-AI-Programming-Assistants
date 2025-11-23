use std::rc::Rc;
use std::cell::RefCell;

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

impl Solution {
    pub fn show_skyline(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        use std::collections::HashSet;

        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, set: &mut HashSet<i32>) {
            if let Some(n) = node {
                let val = n.borrow().val;
                set.insert(val);
                dfs(&n.borrow().left, set);
                dfs(&n.borrow().right, set);
            }
        }

        let mut set = HashSet::new();
        dfs(&root, &mut set);
        set.len() as i32
    }
}

struct Solution;