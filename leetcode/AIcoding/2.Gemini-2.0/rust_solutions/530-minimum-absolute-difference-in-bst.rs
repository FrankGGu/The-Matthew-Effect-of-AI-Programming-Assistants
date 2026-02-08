use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn get_minimum_difference(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        let mut values = Vec::new();
        fn inorder(node: &Option<Rc<RefCell<TreeNode>>>, values: &mut Vec<i32>) {
            if let Some(n) = node {
                inorder(&n.borrow().left, values);
                values.push(n.borrow().val);
                inorder(&n.borrow().right, values);
            }
        }
        inorder(&root, &mut values);

        let mut min_diff = i32::MAX;
        for i in 1..values.len() {
            min_diff = min_diff.min(values[i] - values[i - 1]);
        }
        min_diff
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