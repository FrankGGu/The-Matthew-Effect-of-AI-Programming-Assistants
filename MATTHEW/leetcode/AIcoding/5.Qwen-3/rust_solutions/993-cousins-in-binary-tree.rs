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

pub fn is_cousins(root: Option<Rc<RefCell<TreeNode>>>, x: i32, y: i32) -> bool {
    fn find_node(
        root: &Option<Rc<RefCell<TreeNode>>>,
        target: i32,
        depth: i32,
        parent: Option<i32>,
    ) -> (Option<i32>, i32) {
        if let Some(node) = root {
            let node_ref = node.borrow();
            if node_ref.val == target {
                return (parent, depth);
            }
            let left = find_node(&node_ref.left, target, depth + 1, Some(node_ref.val));
            if left.0.is_some() {
                return left;
            }
            let right = find_node(&node_ref.right, target, depth + 1, Some(node_ref.val));
            return right;
        }
        (None, 0)
    }

    let (x_parent, x_depth) = find_node(&root, x, 0, None);
    let (y_parent, y_depth) = find_node(&root, y, 0, None);

    x_depth == y_depth && x_parent != y_parent
}
}