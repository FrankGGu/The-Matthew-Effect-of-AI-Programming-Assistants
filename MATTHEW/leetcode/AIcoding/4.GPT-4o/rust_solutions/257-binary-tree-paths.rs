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
    fn new(val: i32) -> Self {
        TreeNode {
            val,
            left: None,
            right: None,
        }
    }
}

pub struct Solution;

impl Solution {
    pub fn binary_tree_paths(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<String> {
        let mut paths = Vec::new();
        Self::dfs(root, String::new(), &mut paths);
        paths
    }

    fn dfs(node: Option<Rc<RefCell<TreeNode>>>, path: String, paths: &mut Vec<String>) {
        if let Some(n) = node {
            let n = n.borrow();
            let new_path = if path.is_empty() {
                format!("{}", n.val)
            } else {
                format!("{}->{}", path, n.val)
            };

            if n.left.is_none() && n.right.is_none() {
                paths.push(new_path);
            } else {
                Self::dfs(n.left.clone(), new_path.clone(), paths);
                Self::dfs(n.right.clone(), new_path, paths);
            }
        }
    }
}