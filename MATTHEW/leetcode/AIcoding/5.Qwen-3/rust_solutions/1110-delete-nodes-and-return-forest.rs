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

struct Solution;

impl Solution {
    pub fn del_nodes(
        root: Option<Rc<RefCell<TreeNode>>>,
        to_delete: Vec<i32>,
    ) -> Vec<Option<Rc<RefCell<TreeNode>>>> {
        let mut result = Vec::new();
        let to_delete_set: std::collections::HashSet<_> = to_delete.into_iter().collect();

        fn helper(
            node: Option<Rc<RefCell<TreeNode>>>,
            to_delete: &std::collections::HashSet<i32>,
            result: &mut Vec<Option<Rc<RefCell<TreeNode>>>>,
            is_root: bool,
        ) -> Option<Rc<RefCell<TreeNode>>> {
            if let Some(n) = node {
                let val = n.borrow().val;
                let left = helper(n.borrow().left.clone(), to_delete, result, false);
                let right = helper(n.borrow().right.clone(), to_delete, result, false);

                if to_delete.contains(&val) {
                    if !is_root {
                        return None;
                    } else {
                        if left.is_some() {
                            result.push(left);
                        }
                        if right.is_some() {
                            result.push(right);
                        }
                        return None;
                    }
                }

                let mut new_node = Rc::clone(&n);
                new_node.borrow_mut().left = left;
                new_node.borrow_mut().right = right;

                if is_root {
                    result.push(Some(new_node));
                }

                Some(new_node)
            } else {
                None
            }
        }

        helper(root, &to_delete_set, &mut result, true);
        result
    }
}
}