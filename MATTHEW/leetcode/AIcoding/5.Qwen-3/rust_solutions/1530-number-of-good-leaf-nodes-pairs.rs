impl Solution {

use std::rc::Rc;
use std::cell::RefCell;

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

pub struct Solution {}

impl Solution {
    pub fn number_of_good_leaf_nodes_pairs(root: Option<Rc<RefCell<TreeNode>>>, distance: i32) -> i32 {
        fn dfs(node: &Option<Rc<RefCell<TreeNode>>>, distance: i32) -> Vec<i32> {
            if let Some(n) = node {
                let n = n.borrow();
                if n.left.is_none() && n.right.is_none() {
                    return vec![0];
                }

                let left = dfs(&n.left, distance);
                let right = dfs(&n.right, distance);

                let mut count = 0;
                for l in &left {
                    for r in &right {
                        if l + r + 2 <= distance {
                            count += 1;
                        }
                    }
                }

                let mut res = Vec::new();
                for l in &left {
                    res.push(l + 1);
                }
                for r in &right {
                    res.push(r + 1);
                }

                res.push(count);
                res
            } else {
                vec![]
            }
        }

        dfs(&root, distance).iter().sum()
    }
}
}