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

pub fn get_directions(
    root: Option<Rc<RefCell<TreeNode>>>,
    start_value: i32,
    target_value: i32,
) -> String {
    fn find_path(
        root: &Option<Rc<RefCell<TreeNode>>>,
        target: i32,
        path: &mut Vec<char>,
    ) -> bool {
        if let Some(node) = root {
            let node_ref = node.borrow();
            if node_ref.val == target {
                return true;
            }
            path.push('L');
            if find_path(&node_ref.left, target, path) {
                return true;
            }
            path.pop();
            path.push('R');
            if find_path(&node_ref.right, target, path) {
                return true;
            }
            path.pop();
        }
        false
    }

    let mut path_to_start = Vec::new();
    let mut path_to_target = Vec::new();

    fn find_path_helper(
        root: &Option<Rc<RefCell<TreeNode>>>,
        target: i32,
        path: &mut Vec<char>,
    ) -> bool {
        if let Some(node) = root {
            let node_ref = node.borrow();
            if node_ref.val == target {
                return true;
            }
            path.push('L');
            if find_path_helper(&node_ref.left, target, path) {
                return true;
            }
            path.pop();
            path.push('R');
            if find_path_helper(&node_ref.right, target, path) {
                return true;
            }
            path.pop();
        }
        false
    }

    find_path_helper(&root, start_value, &mut path_to_start);
    find_path_helper(&root, target_value, &mut path_to_target);

    let mut i = 0;
    while i < path_to_start.len() && i < path_to_target.len() && path_to_start[i] == path_to_target[i] {
        i += 1;
    }

    let mut result = String::new();
    for _ in 0..(path_to_start.len() - i) {
        result.push('U');
    }
    for j in i..path_to_target.len() {
        result.push(path_to_target[j]);
    }

    result
}
}