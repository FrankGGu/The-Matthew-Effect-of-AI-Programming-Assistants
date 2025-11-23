impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    let mut path = Vec::new();
    dfs(root, target_sum, &mut result, &mut path);
    result
}

fn dfs(
    root: Option<Rc<RefCell<TreeNode>>>,
    remaining: i32,
    result: &mut Vec<Vec<i32>>,
    path: &mut Vec<i32>,
) {
    if let Some(node) = root {
        let node = node.borrow();
        path.push(node.val);
        if remaining - node.val == 0 && node.left.is_none() && node.right.is_none() {
            result.push(path.clone());
        } else {
            dfs(node.left.clone(), remaining - node.val, result, path);
            dfs(node.right.clone(), remaining - node.val, result, path);
        }
        path.pop();
    }
}
}