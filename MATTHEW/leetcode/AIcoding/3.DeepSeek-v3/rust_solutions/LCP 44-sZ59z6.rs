use std::rc::Rc;
use std::cell::RefCell;
use std::collections::HashSet;

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
    pub fn num_color(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut colors = HashSet::new();
        Self::dfs(&root, &mut colors);
        colors.len() as i32
    }

    fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, colors: &mut HashSet<i32>) {
        if let Some(n) = node {
            let n = n.borrow();
            colors.insert(n.val);
            Self::dfs(&n.left, colors);
            Self::dfs(&n.right, colors);
        }
    }
}