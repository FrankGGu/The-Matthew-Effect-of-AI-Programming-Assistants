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
use std::collections::HashMap;

impl Solution {
    pub fn path_sum(root: Option<Rc<RefCell<TreeNode>>>, target_sum: i32) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, target_sum: i32, current_sum: i32, prefix_sums: &mut HashMap<i32, i32>) -> i32 {
            if let Some(node_ref) = node {
                let node = node_ref.borrow();
                let new_sum = current_sum + node.val;

                let mut count = prefix_sums.get(&(new_sum - target_sum)).copied().unwrap_or(0);

                *prefix_sums.entry(new_sum).or_insert(0) += 1;

                count += dfs(&node.left, target_sum, new_sum, prefix_sums);
                count += dfs(&node.right, target_sum, new_sum, prefix_sums);

                *prefix_sums.entry(new_sum).or_insert(0) -= 1;

                count
            } else {
                0
            }
        }

        let mut prefix_sums: HashMap<i32, i32> = HashMap::new();
        prefix_sums.insert(0, 1);

        dfs(&root, target_sum, 0, &mut prefix_sums)
    }
}

struct Solution;