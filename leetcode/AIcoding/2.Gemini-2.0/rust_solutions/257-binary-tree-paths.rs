use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn binary_tree_paths(root: Option<Rc<RefCell<TreeNode>>>) -> Vec<String> {
        let mut paths = Vec::new();
        if let Some(node) = root {
            Self::dfs(node, String::new(), &mut paths);
        }
        paths
    }

    fn dfs(node: Rc<RefCell<TreeNode>>, current_path: String, paths: &mut Vec<String>) {
        let val = node.borrow().val.to_string();
        let new_path = if current_path.is_empty() {
            val
        } else {
            format!("{}->{}", current_path, val)
        };

        if node.borrow().left.is_none() && node.borrow().right.is_none() {
            paths.push(new_path);
        } else {
            if let Some(left) = node.borrow().left.clone() {
                Self::dfs(left, new_path.clone(), paths);
            }
            if let Some(right) = node.borrow().right.clone() {
                Self::dfs(right, new_path, paths);
            }
        }
    }
}

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

struct Solution;