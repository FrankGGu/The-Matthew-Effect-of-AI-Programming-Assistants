impl Solution {

use std::cell::RefCell;
use std::rc::Rc;

#[derive(Debug, PartialEq, Eq)]
pub struct TreeNode {
    pub val: i32,
    pub left: Option<Rc<RefCell<TreeNode>>>,
    pub right: Option<Rc<RefCell<TreeNode>>>,
}

pub fn find_number_of_coins_to_place_in_tree_nodes(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
    fn dfs(node: &Rc<RefCell<TreeNode>>, parent: Option<&Rc<RefCell<TreeNode>>>) -> i32 {
        let mut count = 0;
        let node_borrow = node.borrow();
        if let Some(left) = &node_borrow.left {
            count += dfs(left, Some(node));
        }
        if let Some(right) = &node_borrow.right {
            count += dfs(right, Some(node));
        }
        if let Some(parent) = parent {
            let parent_borrow = parent.borrow();
            if parent_borrow.val == 0 {
                count += 1;
            }
        }
        count
    }

    match root {
        Some(root_node) => dfs(&root_node, None),
        None => 0,
    }
}
}