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

use std::rc::Rc;
use std::cell::RefCell;

impl Solution {
    pub fn add_one_row(root: Option<Rc<RefCell<TreeNode>>>, val: i32, depth: i32) -> Option<Rc<RefCell<TreeNode>>> {
        if depth == 1 {
            let mut new_node = TreeNode::new(val);
            new_node.left = root;
            return Some(Rc::new(RefCell::new(new_node)));
        }

        fn dfs(node: Option<Rc<RefCell<TreeNode>>>, val: i32, depth: i32, current_depth: i32) {
            if let Some(n) = node {
                if current_depth == depth - 1 {
                    let left = n.borrow_mut().left.take();
                    let right = n.borrow_mut().right.take();

                    let mut new_left = TreeNode::new(val);
                    new_left.left = left;
                    n.borrow_mut().left = Some(Rc::new(RefCell::new(new_left)));

                    let mut new_right = TreeNode::new(val);
                    new_right.right = right;
                    n.borrow_mut().right = Some(Rc::new(RefCell::new(new_right)));
                } else {
                    dfs(n.borrow().left.clone(), val, depth, current_depth + 1);
                    dfs(n.borrow().right.clone(), val, depth, current_depth + 1);
                }
            }
        }

        dfs(root.clone(), val, depth, 1);
        root
    }
}

struct Solution;