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
    pub fn average_of_subtree(root: Option<Rc<RefCell<TreeNode>>>) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, count: &mut i32) -> (i32, i32) {
            match node {
                Some(n) => {
                    let node = n.borrow();
                    let (left_sum, left_count) = dfs(&node.left, count);
                    let (right_sum, right_count) = dfs(&node.right, count);

                    let total_sum = node.val + left_sum + right_sum;
                    let total_count = 1 + left_count + right_count;

                    if total_sum / total_count == node.val {
                        *count += 1;
                    }

                    (total_sum, total_count)
                }
                None => (0, 0),
            }
        }

        let mut count = 0;
        dfs(&root, &mut count);
        count
    }
}

struct Solution;